import csv
import qrcode

def create_contact_qr(file_path):
    # Open the CSV file
    with open(file_path, newline='') as csvfile:
        # Read the rows of the CSV file into a dictionary
        reader = csv.DictReader(csvfile)

        # Loop through each row in the CSV file and create a vCard string and QR code for each
        for row in reader:
            # Create the vCard string
            vcard = f"BEGIN:VCARD\nVERSION:3.0\nN:{row['Last Name']};{row['First Name']}\nORG:{row['Designation']}\nTEL;TYPE=work,voice:{row['Extension']}\nTEL;TYPE=mobile,voice:{row['Mobile']}\nEMAIL:{row['Email']}\nADR;TYPE=work:;;{row['Fax']};{row['Country']}\nURL:{row['Web']}\nEND:VCARD"
            
            # Create the QR code
            qr_code = qrcode.QRCode(
                version=None,
                error_correction=qrcode.constants.ERROR_CORRECT_L,
                box_size=10,
                border=4,
            )
            qr_code.add_data(vcard)
            qr_code.make(fit=True)
            img = qr_code.make_image(fill_color="black", back_color="white")

            # Save the QR code image to a file
            filename = f"{row['First Name']}_{row['Last Name']}.png"
            img.save(filename)
            print(f"QR code saved to {filename}")

if __name__ == "__main__":
    create_contact_qr("contacts.csv")

