i=1
for f in "Pasted image "*.png; do
    mv "$f" "Verdejo$i.png"
    ((i++))
done
