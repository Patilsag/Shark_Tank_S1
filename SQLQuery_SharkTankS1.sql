select * from dbo.data

---total episodes of shark tank

select count(distinct EpiNo) from dbo.data

---pitches

select count(distinct Brand) from dbo.data

---pitches made deal

select COUNT(AmountInvestedlakhs) as Converted_Pitch from dbo.data where AmountInvestedlakhs > 0 

--or

select AmountInvestedlakhs, case when AmountInvestedlakhs > 0 then 1 else 0 end  as Coverted_Not_Converted from dbo.data


select count(*) as Total_Pitches, sum(Coverted_Or_NotConverted) as Converted_Pitch from
(select AmountInvestedlakhs, case when AmountInvestedlakhs > 0 then 1 else 0 end as Coverted_Or_NotConverted from dbo.data) a 

---Success Ratio

select cast (sum(Coverted_Or_NotConverted) as float)/cast (count(*) as float) * 100 as Succes_Rate from
(select AmountInvestedlakhs, case when AmountInvestedlakhs > 0 then 1 else 0 end as Coverted_Or_NotConverted from dbo.data) a 



select * from dbo.data


----Total no. male participants 

select sum(male) from dbo.data

----Total no. female participants 

select sum(female) from dbo.data

----Find Gender/Sex ratio

select Female_Participants/Male_Participants * 100 from 
(select sum(male) as Male_Participants, sum(female) as Female_Participants from dbo.data) a


--Total Amount invested in shark Tank S1
select sum(AmountInvestedlakhs) * 100000 from dbo.data

--- What is the avg equity taken


select avg(EquityTakenP) from dbo.data where EquityTakenP > 0

---Max amount invested by shark
select max(AmountInvestedlakhs) from dbo.data

----startup having atleast one women

select count(brand) from dbo.data
where female >= 1

----Pitches converted having atleast one women

select count(brand) from dbo.data
where female >= 1 and AmountInvestedlakhs > 0


----average team members

select AVG(Team_members) from dbo.data

amount invested per deal

select * from dbo.data

---Amount invested per deal

select avg (AmountInvestedlakhs) from
(select AmountInvestedlakhs from dbo.data
where AmountInvestedlakhs > 0) a



---avg age group of contestants

select avg_age, count(avg_age) Count_agr_grp from dbo.data group by avg_age order by Count_agr_grp desc

---avg loaction group of contestants

select location, count(location) Count_location from dbo.data group by location order by Count_location desc


---which sector of contestants made deal

select sector, count(sector) Count_agr_grp from dbo.data group by sector 
order by Count_agr_grp desc 


--- Making the deal

select Partners, count(Partners) Count_Partners_Group from dbo.data 
where Partners != '-'
group by Partners 
order by Count_Partners_Group desc 


---making the matrix

select a.Shark, a.Ashneer_deals, b.AmountInvested, b.EquityTaken, c.Total_deals from 
(select 'Ashneer' as Shark, count(Ashneer_Amount_Invested) Ashneer_deals from dbo.data 
where Ashneer_Amount_Invested is not null and Ashneer_Amount_Invested > 0) a
inner join 
(select 'Ashneer' as Shark, sum(Ashneer_Amount_Invested) AmountInvested, avg(Ashneer_Equity_TakenP) EquityTaken from dbo.data 
where Ashneer_Equity_TakenP is not null and Ashneer_Equity_TakenP > 0) b
on a.Shark = b.Shark
join 
(select 'Ashneer' as Shark, count(Ashneer_Amount_Invested) Total_deals from dbo.data) c
on a.Shark = c.Shark

---Which is the startup in which highest amount has been invested in each domain/sector

select Brand, sector, AmountInvestedlakhs from (
select Brand, sector, AmountInvestedlakhs, RANK() over (partition by sector order by AmountInvestedlakhs desc) as rnk from dbo.data
where sector is not null and AmountInvestedlakhs != 0) c
where rnk = 1