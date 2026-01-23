i=1
for f in "Pasted image "*.png; do
    mv "$f" "Allien$i.png"
    ((i++))
done
