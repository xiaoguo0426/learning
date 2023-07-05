
```
//查询不连续的id
select id from (select id from Test order by id asc) t where not exists (select 1 from Test
 where id=t.id-1)

 ```
