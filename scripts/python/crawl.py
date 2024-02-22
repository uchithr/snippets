import requests
from bs4 import BeautifulSoup

# specify the base URL and the range of page numbers to crawl
base_url = 'https://ips.to/'
start_page = 101
end_page = 213

# loop through the page range and crawl each page
links = []
for i in range(start_page, end_page+1):
    url = f"{base_url}page/{i}/"
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # find all links on the page and append them to the list
    for link in soup.find_all('a', href=True):
        href = link['href']
        if href.startswith(base_url) and '/category/' not in href:
            links.append(href)

# write the links to a text file
with open('links.txt', 'w') as f:
    for link in links:
        f.write(link + '\n')
        
print(f"Found {len(links)} links")