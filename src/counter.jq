def counter(stream):
    reduce stream as $s ({}; .[$s|tostring] += 1);
