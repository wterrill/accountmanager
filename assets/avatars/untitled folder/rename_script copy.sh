for i in $(ls *)
do
  echo "+++"
  mv -- "$i" "avatar_$i"
  echo "$i"
  echo "avatar_$i"
  echo "---"
done
