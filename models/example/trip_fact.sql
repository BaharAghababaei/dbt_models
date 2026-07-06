
with trips as (

    select distinct
        ride_id,
        to_date(to_timestamp_ntz(started_at)) as trip_date,
        start_statio_id as station_id,
        end_station_id,
        member_csual as member_casual,
        timestampdiff(
            second,
            to_timestamp_ntz(started_at),
            to_timestamp_ntz(ended_at)
        ) as trip_duration_second

    from {{ ref('stg_bike') }}
    where ride_id!='ride_id'

)

select *
from trips
