./$1 < $2_inp > $2_ans
diff $2_cor $2_ans > temp
num=`wc -l < temp`
rm temp
#echo "./$1 < $2_inp > $2_ans"
if [ "$num" -eq "0" ]
then
	echo '\033[0;32m'"OK :)"'\033[0m'
else
	echo '\033[0;31m'"KO :("'\033[0m'
fi