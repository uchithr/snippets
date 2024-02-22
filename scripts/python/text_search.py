import os
import chardet

def search_files(folder_path, query):
    # Convert the query to lowercase
    query = query.lower()
    
    results = []
    for root, dirs, files in os.walk(folder_path):
        # Iterate over all files in the current directory
        for file_path in files:
            # Check if the file is a text file
            if file_path.endswith('.txt'):
                # Detect the encoding of the file using chardet
                with open(os.path.join(root, file_path), 'rb') as f:
                    raw_contents = f.read()
                    detected_encoding = chardet.detect(raw_contents)['encoding']

                # Open the file with the correct encoding and search for the query string
                with open(os.path.join(root, file_path), 'r', encoding=detected_encoding) as f:
                    contents = f.read().lower()  # Convert contents to lowercase
                    if query in contents:
                        results.append(os.path.join(root, file_path))
    return results

# Example usage
current_directory = os.getcwd()
query = 'SASHA'
results = search_files(current_directory, query)
print(f"Results for query '{query}':")
for result in results:
    print(result)
