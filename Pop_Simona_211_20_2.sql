-- POP SIMONA
-- grupa 211
-- calculator 20
-- numar 2

--EX 1
select cod_bilet Biletul, pret "Pretul biletului", e.cod_ev Evenimentul, nume "Numele evenimentului", data "Data evenimentului", suma
from evenimente e join bilete b on(e.cod_ev = b.cod_eveniment) join sponsorizeaza s on(s.cod_ev = e.cod_ev)
order by suma desc;      

--EX 2
--a)
desc sponsorizeaza;
alter table evenimente
add(suma_totala number(12));
--b)
alter table evenimente 
modify(suma_totala varchar2(30));
update evenimente ev
set suma_totala = (select nvl(to_char(sum(suma)),'Caritabil')
                   from sponsorizeaza s right join evenimente e on(s.cod_ev = e.cod_ev)
                   where ev.cod_ev = e.cod_ev
                   group by e.cod_ev);
select * from evenimente;
desc evenimente;
rollback;
commit;

--EX 3
select cod_companie Companie, c.nume "Numele companiei", e.cod_ev Eveniment, e.nume "Numele evenimentului", 
                                (select count(cod_ev)
                                from sponsorizeaza
                                where cod_comp = s.cod_comp
                                group by cod_comp) "Nr tot sponsorizari per comp"
from companii c full join sponsorizeaza s on(c.cod_companie = s.cod_comp) full join evenimente e on(e.cod_ev = s.cod_ev);

--EX 4
select cod_companie, c.nume, tara_origine
from companii c join sponsorizeaza s on(c.cod_companie = s.cod_comp)
where cod_ev in (select cod_ev
                 from sponsorizeaza
                 where cod_comp = 5204)
and c.cod_companie != 5204
group by cod_companie, c.nume, tara_origine
having count(cod_ev) = (select count(cod_ev)
                        from sponsorizeaza
                        where cod_comp = 5204);
select * from sponsorizeaza;