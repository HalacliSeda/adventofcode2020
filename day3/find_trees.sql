CREATE TABLE day3 (c1 int generated always as identity, c2 text);

COPY day3(c2) FROM PROGRAM 'curl -b  https://adventofcode.com/2020/day/3/input';

part1:

SELECT count(c2)
FROM day3
WHERE SUBSTRING(day3.c2 FROM ((3*(day3.c1-1))%length(day3.c2))+1 FOR 1) = '#';

part2:

SELECT tmp.v1*tmp.v2*tmp.v3*tmp.v4*tmp.v5 as result FROM (
SELECT count(*) FILTER (WHERE SUBSTRING(day3.c2 FROM (1 * (day3.c1 - 1)) % length(day3.c2) + 1 FOR 1) = '#') as v1 ,
count(*) FILTER (WHERE SUBSTRING(day3.c2 FROM (3 * (day3.c1 - 1)) % length(day3.c2) + 1 FOR 1) = '#') as v2 ,
count(*) FILTER (WHERE SUBSTRING(day3.c2 FROM (5 * (day3.c1 - 1)) % length(day3.c2) + 1 FOR 1) = '#') as v3 ,
count(*) FILTER (WHERE SUBSTRING(day3.c2 FROM (7 * (day3.c1 - 1)) % length(day3.c2) + 1 FOR 1) = '#') as v4 ,
count(*) FILTER (WHERE SUBSTRING(day3.c2 FROM (day3.c1 / 2) % length(day3.c2) + 1 FOR 1) = '#' AND  c1 % 2 = 1) as v5
FROM day3) as tmp;
