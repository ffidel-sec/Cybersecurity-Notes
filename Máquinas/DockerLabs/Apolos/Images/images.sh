i=1
for f in "Pasted image "*.png; do
    mv "$f" "Apolos$i.png"
    ((i++))
done
