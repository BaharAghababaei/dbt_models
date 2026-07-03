with daily_weather as(

    select
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    from {{ source('demo', 'weather') }}
),
daily_weather_agg as(
    select
    daily_weather,
    weather,
    round(avg(temp),2)        as avg_temp,
    round(avg(pressure),2)    as avg_pressure,
    round(avg(humidity),2)    as avg_humidity,
    round(avg(clouds),2)      as avg_clouds,
    
    row_number() over (partition by daily_weather order by count(weather) desc) as row_number
    from daily_weather
    group by 1,2
    order by 1,2
)

select
daily_weather,
weather,
avg_temp,
avg_pressure,
avg_humidity,
avg_clouds
from daily_weather_agg where row_number=1