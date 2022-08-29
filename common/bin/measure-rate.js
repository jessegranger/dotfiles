#!/usr/bin/env node

class MovingAverage {
	constructor(period, value=0) {
		this.period = period;
		this.value = value;
	}
	add(n) {
		return this.value = ((this.value * (this.period - 1)) + n) / this.period
	}
}

averageInterval = new MovingAverage(1000, 3);
countOccurences = (sub, str) => {
	var from = 0, count = 0;
	while( (from = str.indexOf(sub, from) + 1) > 0 ) count += 1;
	return count;
}

lastEventTime = Date.now()
process.stdin.on('data', (data) => {
	dt = Date.now() - lastEventTime
	lastEventTime += dt
	lines = countOccurences("\n", String(data))
	averageInterval.add(dt/lines)
	process.stdout.write("\r" + (1000 / averageInterval.value).toFixed(2) + " per second     ");
})

process.stdin.on('end', process.exit);
