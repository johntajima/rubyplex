# CURL responses

- run curl commands
- copy body from output to new file
- reformat JSON and save as .json file

# library.all
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         --header "X-Plex-Container-Start: 2000"\
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

# all shows
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         --header "X-Plex-Container-Start: 1"\
         --header "X-Plex-Container-Size: 2"\
         http://192.168.2.5:32400/library/sections/2/all > test/fixtures/shows_all.txt

# show 1 children
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         http://192.168.2.5:32400/library/metadata/10401/allLeaves > test/fixtures/show_1.txt

# show 2 children
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         http://192.168.2.5:32400/library/metadata/10320/allLeaves > test/fixtures/show_1.txt

# show 1 metadata
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         http://192.168.2.5:32400/library/metadata/10401 > test/fixtures/show_details.txt

# movie 1
curl -is --header "X-Plex-Token: _3ZFfNvrYhZ9awqszJ_m"\
         --header "Accept: application/json"\
         http://192.168.2.5:32400/library/metadata/24383 > test/fixtures/movie_1.txt


16469