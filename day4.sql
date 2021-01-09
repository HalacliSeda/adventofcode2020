CREATE TABLE day4 (c1 int generated always as identity, c2 text);

COPY day4(c2) FROM PROGRAM 'curl -b   https://adventofcode.com/2020/day/4/input';


part1:

with
gather as (  select string_agg(c2, ' ') as c2_all from day4
),
splitting as ( select regexp_split_to_table(c2_all, '  ') as passports from gather
)
select * from splitting
where passports::text ilike ANY (ARRAY['%byr%'::text]) and
passports::text ilike ANY (ARRAY['%iyr%'::text]) and
passports::text ilike ANY (ARRAY['%eyr%'::text]) and
passports::text ilike ANY (ARRAY['%hgt%'::text]) and
passports::text ilike ANY (ARRAY['%hcl%'::text]) and
passports::text ilike ANY (ARRAY['%ecl%'::text]) and
passports::text ilike ANY (ARRAY['%pid%'::text]) ;


part2:

with
gather as (  select string_agg(c2, ' ') as c2_all from day4
),
splitting as ( select regexp_split_to_table(c2_all, '  ') as passports from gather
),
matches as (select  regexp_matches(passports, 'byr:(\S+)') as byr,
                    regexp_matches(passports, 'iyr:(\S+)') as iyr,
                    regexp_matches(passports, 'eyr:(\S+)') as eyr,
                    regexp_matches(passports, 'hgt:(\S+)cm') as hgt_cm,
                    regexp_matches(passports, 'hgt:(\S+)in') as hgt_in,
                    regexp_matches(passports, 'hcl:#(\S+)') as hcl,
                    regexp_matches(passports, 'ecl:(\S+)') as ecl,
                    regexp_matches(passports, 'pid:(\S+)') as pid

 from splitting
)
select count(*)  from matches
where (byr[1]::int between 1920 and 2002)
and (iyr[1]::int between 2010 and 2020)
and (eyr[1]::int between 2020 and 2030)
and ((hgt_cm[1]::int between 150 and 193) or (hgt_in[1]::int between 59 and 76))
and (hcl[1]  ~* '[a-f0-9]')
and (ecl[1]::text similar to 'amb|blu|brn|gry|grn|hzl|oth')
and (length(pid[1])=9)
 ;
