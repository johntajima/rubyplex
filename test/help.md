# CURL responses

# library.all
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         --header "X-Plex-Container-Start: 1"\
         --header "X-Plex-Container-Size: 5"\
         http://192.168.2.5:32400/library/sections/1/all > ./fixtures/library_all.txt

# total_count
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         --header "X-Plex-Container-Start: 0"\
         --header "X-Plex-Container-Size: 0"\
         http://192.168.2.5:32400/library/sections/1/all > test/fixtures/total_count_movies.txt

curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         --header "X-Plex-Container-Start: 0"\
         --header "X-Plex-Container-Size: 0"\
         http://192.168.2.5:32400/library/sections/2/all > test/fixtures/total_count_shows.txt

# libraries
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m" --header "Accept: application/json"\
         http://192.168.2.5:32400/library/sections > test/fixtures/libraries.txt
