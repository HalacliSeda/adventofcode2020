
CREATE TABLE day1 (entries int);

COPY day1 FROM PROGRAM 'curl -b "session=" https://adventofcode.com/2020/day/1/input'

Part 1:

SELECT x.entries * y.entries
FROM day1 AS x,
     day1 AS y
WHERE x.entries = 2020 - y.entries
LIMIT 1;


PART 2:

SELECT x.entries * y.entries * z.entries
FROM day1 AS x,
     day1 AS y,
     day1 as z
WHERE x.entries + y.entries + z.entries = 2020
LIMIT 1;
