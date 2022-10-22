Ehdin jo tehdä tehtävän ennen kuin luin, että homma piti copy&pasteta tänne. Jostain syystä itselläni tuo Ruby console printtailee jotenkin kummasti asioita ja välillä käskyn kirjoitus siirtyy konsoli-ikkunan yläreunaan. Toki ikkunaa voi rullata ylös, mutta tuolloin osa asioista on kadonnut (kts. [kuvakaappaus](exercise1.png)). Tästä syystä pystyn kirjoittamaan vastaukseen pelkät komennot. 

```ruby
Brewery.create name: "BrewDog", year: 2007

br = Brewery.find_by name: "BrewDog"

br.beers.create name: "Punk IPA", style: "IPA"

br.beers.create name: "Nanny State", style: "lowalcohol"
```
