KcPage.all.each do |kcpage|
  kcpage.destroy
end
KcPage.find_or_create_by_title("Getting Started").update_attributes(:url=>"getting_started", :sort_order=>1, :published=>true, :html=>"
  <div class='getting-started-content'>
    <ul>
      <li style='float: left;'>
        <img src='/assets/getting-started1.png' />
        <label style='font-size:16px;font-weight:600'>Tour the Facility</label>
        <label>Take a virtual walk-through of our facility and see what's behind this revlutionary medicien.</label>
      </li>
      <li style='float: left;'>
        <img src='/assets/getting-started2.png' />
        <label style='font-size:16px;font-weight:600'>Download Welcome Package</label>
        <label>Bring this package along to your next appointment and learn how to talk to your doctor about MediJean.</label>
      </li>
    </ul>
  </div>",
  :visible_to_doctors => false, :visible_to_patients => true)
KcPage.find_or_create_by_title("FAQs").update_attributes(:url=>"faqs", :sort_order=>2, :published=>true, :html=>"
  <div class='faq-content'>
    <ul>
      <li>
        Is Medicinal Marijuana safe?
      </li>
      <li>
        How do I find a doctor that prescribes?
      </li>
      <li>
        Is there a limit to how much my doctor can prescribe?
      </li>
      <li>
        How much does MediJean Cost?
      </li>
      <li>
        What are the benefits of MediJean?
      </li>
      <li>
        How long does it take to ship?
      </li>
      <li>
        How much does shipping cost?
      </li>
      <li>
        What is the Refund Policy?
      </li>
      <li>
        What is the recommended ingestion method?
      </li>
      <li>
        Where can I buy a vaporizer?
      </li>
    </ul>
  </div>",
  :visible_to_doctors => false, :visible_to_patients => true)
KcPage.find_or_create_by_title("Prescribing 101").update_attributes(:url=>"prescribing", :sort_order=>3, :published=>true, :html=>"
  <div class='prescribing-content'>
    <ul>
      <li style='float: left;'>
        <img src='/assets/priscrib_img.png' />
        <label style='font-size:16px;font-weight:600'>Prescribing 101</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li style='float: left;'>
        <img src='/assets/priscrib_img.png' />
        <label style='font-size:16px;font-weight:600'>How to Prescribe</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li style='float: left;'>
        <img src='/assets/priscrib_img.png' />
        <label style='font-size:16px;font-weight:600'>Learn more about prescribing</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li style='float: left;'>
        <img src='/assets/priscrib_img.png' />
        <label style='font-size:16px;font-weight:600'>Things to watch out for</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
    </ul>
  </div>",
  :visible_to_doctors => true, :visible_to_patients => false)
KcPage.find_or_create_by_title("MediJean Strains").update_attributes(:url=>"medijean_strains", :sort_order=>4, :published=>true, :html=>"
  <div class='medijean-strains-content'>
    <ul>
      <li>
        <label style='font-size:16px;font-weight:600'>MediJean Strain 1</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li>
        <label style='font-size:16px;font-weight:600'>MediJean Strain 2</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li>
        <label style='font-size:16px;font-weight:600'>MediJean Strain 3</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li>
        <label style='font-size:16px;font-weight:600'>MediJean Strain 4</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
      <li>
        <label style='font-size:16px;font-weight:600'>MediJean Strain 5</label>
        <label>Learn how to prescribe MediJean Night, which is highly effective for cases of epiliepsy, stress and anxiety.</label>
      </li>
    </ul>
  </div>",
  :visible_to_doctors => false, :visible_to_patients => true)
KcPage.find_or_create_by_title("Benefits & Side Effects").update_attributes(:url=>"benefits_side_effects", :sort_order=>5, :published=>true, :html=>"
  <div class='benefiets-side-effect-content'>
    <ul>
      <li>
        <label style='font-size:16px;font-weight:600'>Benefits of MediJean</label>
        <label style='font-size: 15px;'>
          Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci
        </label>
      </li>
      <li>
        <label style='font-size:16px;font-weight:600'>Side Effects</label>
        <label style='font-size: 15px;'>
          Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci Lorem lpsum dolor sit amet, consectetuer adipiscing elit, sed diam nonnummy nibh euismod tinci
        </label>
      </li>
    </ul>
  </div>",
  :visible_to_doctors => false, :visible_to_patients => true)