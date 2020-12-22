CREATE TABLE day2 (password_policy text);
CREATE TABLE day2_copy(password_policy text);
CREATE TABLE day2_split(minval int, maxval int, letter text, password text);

COPY day2 FROM PROGRAM 'curl -b "" https://adventofcode.com/2020/day/2/input';

part1:

with a as (select password_policy from day2)
insert into day2_copy select
regexp_replace(password_policy, ':|-', ' ', 'g')
from a;


INSERT INTO day2_split
SELECT split_part(password_policy, ' ', 1)::int,
split_part(password_policy, ' ', 2)::int ,
split_part(password_policy, ' ', 3),
split_part(password_policy, ' ', 5)  FROM day2_copy;


SELECT  count(*) from day2_split where array_length(array_positions(string_to_array(password, NULL), letter),1)  between minval and maxval;

part2:

SELECT count(*)
FROM day2_split
WHERE (minval = ANY(array_positions(string_to_array(password, NULL), letter))
       AND NOT (maxval = ANY(array_positions(string_to_array(password, NULL), letter))) OR
       maxval = ANY(array_positions(string_to_array(password, NULL), letter))
              AND NOT (minval = ANY(array_positions(string_to_array(password, NULL), letter)))
     );
