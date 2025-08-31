* In `Sort.hs` are implemented four quicksort-esque sorts (named `sort0`, `sort1`, `sort2`, `sort3`).

* From `Main.hs` is built an executable taking a choice of sort (represented as `0`, `1`, `2`, `3`) and a list size (represented as an Int) as command line arguments and then performs said sort on an infelicitously chosen List of Ints, printing the result to standard output.

* In `Prof.sh` is a shell script taking a list size (represented as an Int) and optimization + specialization level (`O0`, `O2N`, `O2Y`) and dumping profiling information of `Main` compiled with said optimization + specialization level and run with said list size for each sort to `./prof`

* In `Dump.sh` is a shell script taking an optimization + specialization level (`O0`, `O2N`, `O2Y`) and dumping the final GHC core output of `Sort` and `Main` compiled with said optimization + specialization level to `./dump`

I.e., everything can be built/run/dumped at once as

```sh
for opt in O0 O2N O2Y
do  sh Prof.sh 5000 "$opt"
    sh Dump.sh "$opt"
done
```

WARNING: In order to run `Prof.sh` you must have [eventlog2html](https://mpickering.github.io/eventlog2html/) installed. Sometimes `eventlog2html` crashes for reasons unbeknownst to me, citing some index-out-of-bounds error. This happens infrequently enough on the inputs here that it generally suffices to simply rerun the script...
