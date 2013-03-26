#pragma D option quiet

objc$target:YM*::entry
{
	start[probemod] = timestamp;	
}

objc$target:YM*::return
{
	printf("%30s %10s Execution time: %u us\n", probemod, probefunc, (timestamp - start[probemod]) / 1000);
}