#!/bin/bash
for i in {0..64..1}
do
        x=$((64+$i))
        s="10.41.33.""$x"
        ping $s -c 1 -w 1
done

# Or try arp-scan  10.41.33.64/26 which should do the same

