create Index "match.id"
on "match"
using btree (id)

create Index "player.id"
on player
using btree (id)

create Index "start_date"
on teamlocation
using btree (start_date)

create Index "finish_date"
on teamlocation
using btree (finish_date)
