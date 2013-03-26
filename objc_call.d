#!/usr/sbin/dtrace -Zs

#pragma D option quiet

objc$1:$2:$3:entry
{
	start[probemod] = timestamp;	
}

objc$1:$2:$3:return
{
	printf("%30s %10s Execution time: %u us\n", probemod, probefunc, (timestamp - start[probemod]) / 1000);
}