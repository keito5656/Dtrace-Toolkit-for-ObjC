#!/usr/sbin/dtrace -Zs

#pragma D option quiet
#pragma D option switchrate=10

self int depth;

objc$1:$2:$3:entry 
{

  printf("->%*s[%s %s]\n",
    self->depth, "", 
    probemod, probefunc);
  self->ts[probefunc] = timestamp;
  self->depth++;
}

objc$1:$2:$3:return
{
  self->depth -= self->depth > 0 ? 1 : 0;
  time = timestamp - self->ts[probefunc];
  printf("<-%*s[%s %s] [%dms]\n",
    self->depth, "",
    probemod, probefunc, time / 1000);
}
