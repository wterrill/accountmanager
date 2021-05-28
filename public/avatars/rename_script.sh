for i in $(ls avatar*)
do
  echo "+++"
  mv -- "$i" "${i/avatar_/avatar_0}"
  echo "$i"
  echo "---"
  echo "${i/avatar_/avatar_0}"
  echo "==="
done
