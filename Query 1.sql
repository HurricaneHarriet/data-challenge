---------------------
--===Part 1 SQL===--
---------------------

/*	Top 5 most popular pieces of content consumed this week. */

select content_id
from Page_Impression
where Timestamp bwtween '2021-8-16' and '2021-8-20'
group by content_id
order by count(Session_id) desc
limit 5；