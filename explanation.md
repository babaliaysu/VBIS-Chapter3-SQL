# SQL Həllərinin İzahı

## 1. Ən çətin hesab etdiyim SQL sorğusu

Ən çətini 3.11(d) oldu. Əvvəl MIN(MAX(salary)) yazmağa çalışdım, amma SQL
aqreqat funksiyanı başqa aqreqatın içinə qoymağa icazə vermir. Məsələni iki
mərhələyə böldüm: əvvəl GROUP BY ilə hər departamentin maksimum maaşını
tapdım, sonra bu nəticədən MIN götürdüm.

## 2. Alt sorğu istifadə etdiyim sorğular

3.11(b)-də WHERE daxilində NOT IN ilə alt sorğu işlətdim. Daxili sorğu
2017-dən əvvəl kurs götürmüş tələbələrin ID-lərini tapır, xarici sorğu isə
ID-si bu siyahıda olmayan tələbələri seçir. 3.11(d)-də alt sorğunu FROM
daxilində müvəqqəti cədvəl kimi istifadə etdim və ona dept_max adı verdim.

## 3. JOIN nümunəsi

3.11(a)-da student, takes və course cədvəllərini birləşdirdim. Tələbənin adı
student-də, götürdüyü kurslar takes-də, kursun departamenti isə course-dadır.
Əvvəl student ilə takes-i ID üzrə, sonra takes ilə course-u course_id üzrə
birləşdirdim. WHERE ilə yalnız Comp. Sci. kurslarını saxladım. Bir tələbə
bir neçə belə kurs götürə bildiyi üçün təkrarlar yarandı, onları DISTINCT
ilə sildim.

## 4. Qarşılaşdığım problem və həlli

Əvvəl NATURAL JOIN düşünürdüm. Amma student və course cədvəllərinin ikisində
dept_name sütunu var və NATURAL JOIN onu da avtomatik birləşdirir. Bu,
başqa departamentdən Comp. Sci. kursu götürən tələbələri nəticədən
çıxarardı. Həll kimi JOIN ... ON yazıb şərtləri özüm göstərdim.