Address.find_or_create(
  city: "Calgary",
  province: "AB",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Barrow").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Calgary",
  province: "AB",
  addressable_id: Doctor.find_or_create(
    first_name: "Marc",
    last_name: "Klasa",
    phone: "403-590-9992").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "#101 - 2296 McCallum Road",
  city: "Abbotsford",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Greenleaf Medical Clinic",
    phone: "604-859-3677",
    website: "http://medicalmarijuana.ca").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Chilliwack",
  province: "BC",
  postal_code: "V2P 6J4",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Gwyllyn",
    last_name: "Goddard",
    phone: "604-858-5300").id)

Address.find_or_create(
  city: "Duncan",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Peter",
    last_name: "Gooch").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Duncan",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Dunlop").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Kelowna",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Donoharm Clinic").id,
  addressable_type: "Doctor")


Address.find_or_create(
  street: "9-3151 Lake Shore Rd",
  unit: "Suite 421",
  city: "Kelowna",
  street: "1745 Spall Rd.",
  postal_code: "V1Y 4P7",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Kevin Jay",
    first_name: "",
    last_name: "Kanerva",
    phone: "(250)860-3456",
    fax: "(250)764-1684").id,
  addressable_type: 'Doctor')

Address.find_or_create(
  city: "Nanaimo",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Peter",
    last_name: "Babuin").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Nanaimo",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Johannes",
    first_name: "",
    last_name: "Olivier").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "450 Nanaimo St",
  city: "Vancouver",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Arnold",
    first_name: "",
    last_name: "Shoichet",
    email: "info@mcrci.com",
    fax: "604.909.1890",
    phone: "604.566.9391",
    website: "http://mmrci.com").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "450 Nanaimo St",
  city: "Vancouver",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "Caroline",
    first_name: "",
    last_name: "Ferris",
    email: "info@mcrci.com",
    fax: "604.909.1890",
    phone: "604.566.9391",
    website: "http://mmrci.com").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "880 E. Hastings",
  city: "Vancouver",
  province: "BC",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Vancouver Medical Cannabis Dispensary",
    phone: "604-255-1844",
    fax: "604-255-1845",
    website: "http://cannabisdispensary.ca").id,
  addressable_type: "Doctor")


Address.find_or_create(
  city: "Halifax",
  province: "NS",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Campbell").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "5820 University Ave.",
  postal_code: "B3H 1V7",
  city: "Halifax",
  province: "NS",
  addressable_id: Doctor.find_or_create(
    first_name: "Mary",
    first_name: "",
    last_name: "Lynch",
    phone: "902 473 6428",
    fax: "902 473 4126",
    email: "mary.lynch@dal.ca").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "16 Church St",
  postal_code: "B4H 3Y6",
  city: "Amherst",
  province: "NS",
  addressable_id: Doctor.find_or_create(
    first_name: "Thomas",
    first_name: "",
    last_name: "Hydorn",
    phone: "902-667-2331").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Halifax",
  postal_code: "B3H 1V7",
  province: "NS",
  addressable_id: Doctor.find_or_create(
    first_name: "Mary",
    last_name: "Lynch",
    phone: "902-473-6428",
    fax: "902-473-4126",
    email: "mary.lynch@dal.ca").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "2165 Gottingen St.",
  city: "Halifax",
  province: "NS",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Campbell",
    phone: "902-420-0303").id,
  addressable_type: "Doctor")


Address.find_or_create(
  street: "139 Brunswick Street",
  postal_code: "E3B 1G7",
  city: "Fredericton",
  province: "NB",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Gary",
    last_name: "Baker",
    phone: "(506) 450-3321").id)

Address.find_or_create(
  street: "800 Priestman St",
  postal_code: "E3B 0C7",
  city: "Fredericton",
  province: "NB",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Colleen",
    last_name: "O'Connell",
    fax: "(506)447-4749",
    phone: "(506)447-4294").id)


Address.find_or_create(
  street: "1015 Regent St",
  postal_code: "E3B 6H5",
  city: "Fredericton",
  province: "NB",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "John",
    last_name: "Keddy",
    phone: "(506) 458-0246",
    fax: "506-458-0264").id)

Address.find_or_create(
  street: "139 Brunswick Street",
  postal_code: "E3B 1G7",
  city: "Fredericton",
  province: "NB",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Douglas",
    last_name: "Smith",
    phone: "(506) 450-3321").id)

Address.find_or_create(
  street: "640 Prospect",
  city: "Fredericton",
  province: "NB",
  postal_code: "E3B 9M7",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Paul",
    last_name: "Smith",
    phone: "(506)455-2900").id)

Address.find_or_create(
  street: "139 Brunswick Street",
  city: "Perth-Andover",
  province: "NB",
  postal_code: "E3B 1G7",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "David",
    last_name: "Bell",
    phone: "(506) 450-3321").id)

Address.find_or_create(
  street: "43 Hillcrest Drive",
  city: "Perth-Andover",
  province: "NB",
  postal_code: "E7H 2G7",
  addressable_id: Doctor.find_or_create(
    first_name: "Larry",
    last_name: "Kennedy",
    phone: "506-273-9522",
    fax: "506-273-6331").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "139 Brunswick Street",
  city: "Woodstock First Nation",
  postal_code: "E3B 1G7",
  province: "NB",
  addressable_type: 'Doctor',
  addressable_id: Doctor.find_or_create(
    first_name: "Michael",
    last_name: "Perley",
    phone: "(506) 450-3321").id)


Address.find_or_create(
  street: "40 Shellington Pl.",
  city: "Brantford",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Dhillon",
    phone: "519-754-2888").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Cochrane",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Li, Cochrane Minto",
    last_name: "Center",
    phone: "705 272-4200").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Coehill",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Kamermans",
    phone: "613-337-8984").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Fort Erie",
  street: "238 Bertie St",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Henry",
    phone: "905-871-6622").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Fort Erie",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Kamatovic;").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Georgian Bay",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Danial",
    last_name: "Schecter",
    website: "http://georgianbayhousecalls.com",
    phone: "705.433.1362").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Hamilton",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Rhydderch").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Hamilton",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Price",
    phone: "1-855-800-2226").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Jarvis",
  street: "2121 Main N",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Mark",
    last_name: "Miller",
    phone: "519-587-2268").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "London",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Patricia Morley-Forster, ").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "2797 Bathurst",
  city: "North York",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Tsvi",
    last_name: "Gallant",
    phone: "416-789-4376").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Ottawa",
  street: "100 Marie Curie Pvt.",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Donald",
    last_name: "Kilby",
    phone: "613-564-3950").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Peterborough",
  street: "140 King St",
  postal_code: "K9J 7Z8",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Mary Lou Mamuri",
    last_name: "Dancel",
    phone: "705-745-8705").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Sarnia",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Glen Madison;").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Sarnia",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Lau;").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Scarborough",
  unit: "207",
  street: "3447 Kennedy Rd.",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Latowsky",
    phone: "416-332-2757",
    fax: "416-332-3747").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "St. Catherines",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Lennox;").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "41-0 Sherbourne",
  city: "Toronto",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Gordon",
    last_name: "Arbess",
    phone: "416-867-3728").id,
  addressable_type: "Doctor")

Address.find_or_create(
  unit: "406",
  street: "235 Danforth",
  city: "Toronto",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "John",
    last_name: "Goodhew",
    phone: "416-463-6929").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "70 Carlton",
  city: "Toronto",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Colin",
    last_name: "Kovacs",
    phone: "416-465-0856").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "2401 Yonge St.",
  city: "Toronto",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "Naomi",
    last_name: "Lear",
    phone: "416-322-9933").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Toronto",
  unit: "201",
  street: "80 Finch W.",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "",
    last_name: "Saul",
    phone: "416-221-3633",
    fax: "416-221-5599").id,
  addressable_type: "Doctor")

Address.find_or_create(
  city: "Woodbridge",
  province: "ON",
  addressable_id: Doctor.find_or_create(
    first_name: "R",
    last_name: "Monson",
    phone: "905-856-2100").id,
  addressable_type: "Doctor")

Address.find_or_create(
  street: "220 Water St",
  postal_code: "C1A 9M5",
  city: "Charlottetown",
  province: "PE",
  addressable_id: Doctor.find_or_create(
    first_name: "Desmond",
    last_name: "Colohan",
    phone: "902-367-3344",
    phone: "902-367-4114").id,
  addressable_type: "Doctor")