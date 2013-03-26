#!/usr/sbin/dtrace -Zs

#pragma D option quiet

dtrace:::BEGIN
{
	printf("Tracing... Hit Ctrl-C to end.\n");
}

objc$target:::entry
{
	self->depth++;
	self->exclude[self->depth] = 0;
	self->sub[self->depth] = timestamp;
}

objc$target:::return
/self->sub[self->depth]/
{
	this->elapsed_incl = timestamp - self->sub[self->depth];
	this->elapsed_excl = this->elapsed_incl - self->exclude[self->depth];
	self->sub[self->depth] = 0;
	self->exclude[self->depth] = 0;
	this->file = probemod;
	this->name = probefunc;

	@types_incl["[incl]", this->file, this->name] =
	    quantize(this->elapsed_incl / 1000);
	@types_excl["[excl]",this->file, this->name] =
	    quantize(this->elapsed_excl / 1000);

	self->depth--;
	self->exclude[self->depth] += this->elapsed_incl;
}

dtrace:::END
{
	printf("\nExclusive subroutine elapsed times (us),\n");
	printa("   %s, %s, %s %@d\n", @types_excl);

	printf("\nInclusive subroutine elapsed times (us),\n");
	printa("   %s, %s, %s %@d\n", @types_incl);
}
