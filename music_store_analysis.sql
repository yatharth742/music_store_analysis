
/*who is the senior most employee based on job title ? */
Select first_name , title , levels
from employee
order by levels desc
limit 1 ;

/* which country has most invoices?  */
select * from invoice;
select count(Customer_id) ,billing_country
from invoice
group by billing_country
order by billing_country desc
limit 1;

/* which are the top 3 values of total invoices? */
select total from invoice
order by total desc
limit 3;

/*  . Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals */
select * from invoice;

select sum(total) as total_invoice_value , billing_city
from invoice
group by billing_city 
order by total_invoice_value desc;

/* Write a query that returns the person who has spent the 
most money   */
select * from invoice;

select sum(total) as total_invoice_value , c.customer_id , c.first_name , c.last_name
from invoice i
join customer c
on i.customer_id = c.customer_id
group by c.customer_id
order by total_invoice_value desc
limit 1 ; 

/* 1. Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A   */

select distinct c.email , c.first_name , c.last_name 
from Genre g
join Track t 
	on g.genre_id = t.genre_id
join invoice_line il
	on t.track_id = il.track_id
join invoice i
	on il.invoice_id = i.invoice_id
join customer c
	on i.customer_id = c.customer_id
where g.name like 'Rock'
order by c.email asc ;

/*Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands    */


select count(a.artist_id) as no_of_music , a.name as namy
from Artist a
join Album ab
	on a.artist_id = ab.artist_id
join track t
	on ab.album_id = t.album_id
join genre g
	on t.genre_id = g.genre_id and  g.name like 'Rock'
group by a.artist_id
order by no_of_music desc
limit 10;

select*from artist;
select*from track ;

/* Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first   */


select name , milliseconds
from track 
where milliseconds >
	(select avg(milliseconds)
	from track)
order by track.milliseconds desc;

/* Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent */

select sum(il.unit_price * il.quantity)  , c.first_name , c.customer_id,a.name
from customer c
join Invoice i
	on c.customer_id = i.customer_id
join invoice_line il
	on i.invoice_id = il.invoice_id
join track t
	on il.track_id = t.track_id
join album ab
	on t.album_id = ab.album_id
join artist a
	on ab.artist_id = a.artist_id
group by  c.first_name , c.customer_id , a.name
order by sum desc;

/* We want to find out the most popular music Genre for each country. We determine the 
most popular genre as the genre with the highest amount of purchases. Write a query 
that returns each country along with the top Genre. For countries where the maximum 
number of purchases is shared return all Genre */

select sum(il.unit_price * il.quantity) , c.country , g.name
from customer c
join Invoice i
	on c.customer_id = i.customer_id
join invoice_line il
	on i.invoice_id = il.invoice_id
join track t
	on il.track_id = t.track_id
join genre g
	on t.genre_id = g.genre_id
group by c.country , g.name
order by sum desc ;

/*  Write a query that determines the customer that has spent the most on music for each 
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all 
customers who spent this amount   */

select sum(il.unit_price * il.quantity)  , c.first_name , c.country
from customer c
join Invoice i
	on c.customer_id = i.customer_id
join invoice_line il
	on i.invoice_id = il.invoice_id
join track t
	on il.track_id = t.track_id
join album ab
	on t.album_id = ab.album_id
join artist a
	on ab.artist_id = a.artist_id
group by  c.first_name , c.country 
order by country desc;















