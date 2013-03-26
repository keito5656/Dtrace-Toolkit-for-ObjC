#!/usr/sbin/dtrace -Zs

#pragma D option quiet
#pragma D option switchrate=10

self int depth;

objc$target:::entry 
{

  printf("[%d][%s %s]\n->",
    self->depth, 
    probemod, probefunc);
  self->ts[probefunc] = timestamp;
  self->depth++;
}

objc$target:::return
{
  self->depth -= self->depth > 0 ? 1 : 0;
  time = timestamp - self->ts[probefunc];
  printf("[%d][%s %s] [%dms]\n<-",
    self->depth,
    probemod, probefunc, time / 1000);
}
