require 'github_api'
load "pw.config"

# Authentication 
github = Github.new login:'mjbrender', password: PW

# hash that will contain all unique users 
all_users = {}

# get all repositories visible under basho-labs
# note that it includes public and private
labs_repos =  github.repos.list org: 'basho-labs', auto_pagination: true
#basho_repos = github.repos.list org: 'basho', auto_pagination: true

# for all repos 
# if key doesn't exist in all_users
# put username as key 
# value = {:lines => 0, :commits => 1, :email => "email@email.com", :org => ["organization", "org2"]}

labs_repos.each do |repo|
    # Make the call to get all users from the repo
    all_contributors = github.repos.list_contributors_with_callback_repos user: 'basho-labs', repo: repo.name, auto_pagination: true

    all_contributors.each do |user|
        key = user.login
        if all_users.value?(key) == false
            all_users[key] = 1
            #exit()
        end
    end
end


puts all_users.length()

# user object returns: 
#<Hashie::Mash avatar_url="https://avatars.githubusercontent.com/u/21?v=3"
#<events_url="https://api.github.com/users/technoweenie/events{/privacy}"
#<followers_url="https://api.github.com/users/technoweenie/followers" following_
#<url="https://api.github.com/users/technoweenie/following{/other_user}"
#<gists_url="https://api.github.com/users/technoweenie/gists{/gist_id}"
#<gravatar_id="" html_url="https://github.com/technoweenie" id=21
#<login="technoweenie"
#<organizations_url="https://api.github.com/users/technoweenie/orgs" received_ev
#<ents_url="https://api.github.com/users/technoweenie/received_events"
#<repos_url="https://api.github.com/users/technoweenie/repos" site_admin=true
#<starred_url="https://api.github.com/users/technoweenie/starred{/owner}{/repo}"
#<subscriptions_url="https://api.github.com/users/technoweenie/subscriptions"
#<type="User" url="https://api.github.com/users/technoweenie">