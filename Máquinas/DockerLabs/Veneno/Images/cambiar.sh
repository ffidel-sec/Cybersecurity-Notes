i=1
for f in "Pasted image "*.png; do
    mv "$f" "Veneno$i.png"
    ((i++))
done
