#!/bin/sh
echo "test.t parse result:" >> result.txt
./parse test.t >> result.txt
echo -n "test.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test1.t parse result:" >> result.txt
./parse test1.t >> result.txt 
echo -n "test1.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test2.t parse result:" >> result.txt
./parse test2.t >> result.txt
echo -n "test2.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test3.t parse result:" >> result.txt
./parse test3.t >> result.txt
echo -n "test3.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test4.t parse result:" >> result.txt
./parse test4.t >> result.txt
echo -n "test4.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test5.t parse result:" >> result.txt
./parse test5.t >> result.txt
echo -n "test5.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt

echo "test7.t parse result:" >> result.txt
./parse test7.t >> result.txt
echo -n "test7.t parse result:" >> final.txt
tail -n 1 result.txt >> final.txt
echo "======================================================================" >> result.txt