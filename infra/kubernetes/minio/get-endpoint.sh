for ep in 10.32.0.5:9000 10.36.0.4:9000 10.38.0.6:9000; do
    wget -qO- $ep
done
