
#生成元组组合
function arrlist(){
let index=0
for num in {0..9}
do
    arr[$index]=$num
    let index+=1
done
for letter in {a..z}
do
    arr[$index]=$letter
    let index+=1
done
}

#取得元素所在元组位置 location "b"
function location(){
  let tem=0
  while [ $tem -lt ${#arr[@]} ]
  do
    if [ ${arr[$tem]} = $1 ]
    then
      echo $tem
      break
    fi
  let tem+=1
  done
}

#根据元组位置返回元素 location2letter "21"
function location2letter(){
  echo ${arr[$1]}
}

function location_plus(){
  let plus_location=$1+1
  echo ${arr[$plus_location]}
}

#生成二级域名的下一个域名 carry "abcd" => abce
function carry(){
  str=$1
  let str_len=${#str}-1
  let r=0
  while [ $r -le  $str_len ]
  do
    arr2[$r]=$(echo $str|cut -c$((r+1)))
    arr3[$r]=$(location ${arr2[$r]})
    let r+=1
  done
  let t=$str_len
  plus_location=false
  let arr3[$t]=${arr3[$t]}+1
  while [ $t -ge 0 ];do
    if [ ${arr3[$t]} -ge $(($arr_max_location+1)) ] ; then
      arr3[$t]='0'
      if [ $t = 0 ] ; then
        plus_location=true
      else
        let arr3[$(($t-1))]=${arr3[$(($t-1))]}+1
      fi
    fi
    let t=$t-1
  done
  for temp2 in ${arr3[*]} ; do
    str_re+=$(location2letter $temp2)
    str_re+=$(location2letter $temp2)
  done
  if $plus_location ; then
    str_re=${arr[0]}$str_re
  fi
    echo $str_re
}

#递归方式生成域名
function gen_domain(){
  ie=$1
  current_length=${#ie}
  echo "$1.com"
  if [ $current_length -lt $(($2+1)) ]
  then
    gen_domain $(carry $1) $2
  fi
}

#生成元素元组集合
arrlist
#最大元素位置
let arr_max_location=${#arr[*]}-1
#默认深度
dept=2
#location "z"
#最大元素位置
let arr_max_location=${#arr[*]}-1
#初始字
init_element="0"
#执行递归方法生成
gen_domain $init_element $dept
