/*	Number of weekly active users for the latest full week 
	(Monday – Sunday). WAU is calculated by counting registered 
	users with > 60 seconds dwell time between Monday-Sunday.  */

select Ads_user_id
from Ad_service_interaction_data 
where Timestamp bwtween '2021-8-16' and '2021-8-20'
group by Ads_user_id
having sum(Dwell_time)>60

select count(User_id)
from Registered_Users a
join OAuth_ID_Service b
on a.OAuth_id = b. OAuth_id
where b.Ads_User_id in (select Ads_user_id
						from Ad_service_interaction_data 
						where Timestamp bwtween '2021-8-16' and '2021-8-20'
						group by Ads_user_id
						having sum(Dwell_time)>60)
group by User_id