{% set congigs = [
    {
        "table" : "AIRBNB.GOLD.OBT",
        "columns": "GOLD_obt.booking_id, GOLD_obt.listing_id, GOLD_obt.host_id, GOLD_obt.total_amount, GOLD_obt.service_fee, GOLD_obt.cleaning_fee, GOLD_obt.accommodates, GOLD_obt.bathrooms, GOLD_obt.bedrooms, GOLD_obt.price_per_night, GOLD_obt.response_rate",
        "alias" : "GOLD_obt",
    },
    {
        "table" : "AIRBNB.GOLD.DIM_LISTINGS",
        "columns": "",
        "alias" : "DIM_listings",
        "join_condition" : "GOLD_obt.listing_id = DIM_listings.listing_id"
    },
    {
        "table" : "AIRBNB.GOLD.DIM_HOSTS",
        "columns": "",
        "alias" : "DIM_hosts",
        "join_condition" : "GOLD_obt.host_id = DIM_hosts.host_id"
    }

]%}

SELECT 
        {{ congigs[0]['columns'] }}
FROM
    {% for config in congigs %}
    {% if loop.first%}
        {{ config['table']}} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ config['table']}} AS {{ config['alias'] }} ON {{ config['join_condition'] }}
    {% endif %}
    {% endfor %}

    