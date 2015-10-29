module ApplicationHelper
  def processblank(value)
    if value.blank? || value.nil? 
      return "---"
    else
      return value
    end
  end

  def comments_by_ticketid(id)
    tmp = Comment.where(:ticket_id=>id)
    retval = tmp.count
    return retval
  end

  def is_superuser(email)
    if email == "cyberadvance@admin.com"
      return "ADMIN"
    else
      return email
    end
  end

  def hp_device(email)
    
    tmp = User.find_by_username(email)

    if !tmp.nil?

      if tmp.is_cdevice || tmp.is_rdevice || tmp.is_mdevice
        return true
      else
        return false
      end
    else
      return false
    end
    
  end

  def hp_ticket(email)
    tmp = User.find_by_username(email)
    if !tmp.nil?
      if tmp.is_rticket || tmp.is_sticket || tmp.is_dticket || tmp.is_wticket
        return true
      else
        return false
      end
    else
      return false
    end    
  end

  def get_dnotes(date, device_name)
    tmp = Dnote.where(:device_name=>device_name).where("updated_at LIKE ?", "%#{date}%").count

    return tmp
  end

  def get_devices(email)
    @own_devices = Device.where(:owner=>email)

    return @own_devices
  end

  def pro_action(text)
    case text
    when "0"
      ret = "Pending"
    when "Allow"
      ret = "Allowed"
    when "Deny"
      ret = "Denied"
    else
      ret = text
    end

    return ret
  end

  def get_colorspan(b_val, value)

    if b_val
      html = '<span style="color:yellow">' + value.to_s + '</span>'
    else
      html = value
    end

    return html
  end

  def get_password(name)
    # tmp = User.where(:username=>name)
    tmp = User.find_by_username(name)
    return tmp.pwd
  end

  def get_duser(name)
    dusers = DeviceUser.find_by_device_name(name)
    
    return dusers
  end

  def get_sortdirection(name)
    if !name.nil?
      tmp = name[name.mb_chars.length-2, name.mb_chars.length]

      if tmp == '_d'
        return '&#9660;'
      end

      if tmp == '_a'
        return '&#9650;'
      end
    end

    return ''
  end

  def getflag_floc(location)
    case location

    when "Amsterdam1"
      return '<i class="netherlands flag" style="font-size:20x;"></i>'
    when "Amsterdam2"
      return '<i class="netherlands flag" style="font-size:20x;"></i>'
    when "Frankfurt2"
      return '<i class="germany flag" style="font-size:20x;"></i>'
    when "HongKong2"
      return '<i class="hong kong flag"  style="font-size:20x;"></i>'
    when "Paris1"
      return '<i class="france flag"  style="font-size:20x;"></i>'
    else
      return '<i class="united states flag"  style="font-size:20x;"></i>'
    end
  end

  def get_countryname(name)
    case name
    when "Andorra"
      html = '<i class="ad flag"></i>'
    when "Afghanistan"
      html = '<i class="af flag"></i>'
    when "Antigua"
      html = '<i class="ag flag"></i>'
    when "Anguilla"
      html = '<i class="ai flag"></i>'
    when "Albania"
      html = '<i class="al flag"></i>'
    when "Armenia"
      html = '<i class="am flag"></i>'
    when "Netherlands Antilles"
      html = '<i class="an flag"></i>'
    when "Angola"
      html = '<i class="ao flag"></i>'
    when "Argentina"
      html = '<i class="ar flag"></i>'
    when "American Samoa"
      html = '<i class="as flag"></i>'
    when "Austria"
      html = '<i class="at flag"></i>'
    when "Australia"
      html = '<i class="au flag"></i>'
    when "Aruba"
      html = '<i class="aw flag"></i>'
    when "Aland Islands"
      html = '<i class="ax flag"></i>'
    when "Azerbaijan"
      html = '<i class="az flag"></i>'
    when "Bosnia"
      html = '<i class="ba flag"></i>'
    when "Barbados"
      html = '<i class="bb flag"></i>'
    when "Bangladesh"
      html = '<i class="bd flag"></i>'
    when "Belgium"
      html = '<i class="be flag"></i>'
    when "Burkina Faso"
      html = '<i class="bf flag"></i>'
    when "Bulgaria"
      html = '<i class="bg flag"></i>'
    when "Bahrain"
      html = '<i class="bh flag"></i>'
    when "Burundi"
      html = '<i class="bi flag"></i>'
    when "Benin"
      html = '<i class="bj flag"></i>'
    when "Bermuda"
      html = '<i class="bm flag"></i>'
    when "Brunei"
      html = '<i class="bn flag"></i>'
    when "Bolivia"
      html = '<i class="bo flag"></i>'
    when "Brazil"
      html = '<i class="br flag"></i>'
    when "Bahamas"
      html = '<i class="bs flag"></i>'
    when "Bhutan"
      html = '<i class="bt flag"></i>'
    when "Bouvet Island"
      html = '<i class="bv flag"></i>'
    when "Botswana"
      html = '<i class="bw flag"></i>'
    when "Belarus"
      html = '<i class="by flag"></i>'
    when "Belize"
      html = '<i class="bz flag"></i>'
    when "Canada"
      html = '<i class="ca flag"></i>'
    when "Cocos Islands"
      html = '<i class="cc flag"></i>'
    when "Congo"
      html = '<i class="cd flag"></i>'
    when "Central African Republic"
      html = '<i class="cf flag"></i>'
    when "Congo Brazzaville"
      html = '<i class="cg flag"></i>'
    when "Switzerland"
      html = '<i class="ch flag"></i>'
    when "Cote Divoire"
      html = '<i class="ci flag"></i>'
    when "Cook Islands"
      html = '<i class="ck flag"></i>'
    when "Chile"
      html = '<i class="cl flag"></i>'
    when "Cameroon"
      html = '<i class="cm flag"></i>'
    when "China"
      html = '<i class="cn flag"></i>'
    when "Colombia"
      html = '<i class="co flag"></i>'
    when "Costa Rica"
      html = '<i class="cr flag"></i>'
    when "Serbia"
      html = '<i class="cs flag"></i>'
    when "Cuba"
      html = '<i class="cu flag"></i>'
    when "Cape Verde"
      html = '<i class="cv flag"></i>'
    when "Christmas Island"
      html = '<i class="cx flag"></i>'
    when "Cyprus"
      html = '<i class="cy flag"></i>'
    when "Czech Republic"
      html = '<i class="cz flag"></i>'
    when "Germany"
      html = '<i class="de flag"></i>'
    when "Djibouti"
      html = '<i class="dj flag"></i>'
    when "Denmark"
      html = '<i class="dk flag"></i>'
    when "Dominica"
      html = '<i class="dm flag"></i>'
    when "Dominican Republic"
      html = '<i class="do flag"></i>'
    when "Algeria"
      html = '<i class="dz flag"></i>'
    when "Ecuador"
      html = '<i class="ec flag"></i>'
    when "Estonia"
      html = '<i class="ee flag"></i>'
    when "Egypt"
      html = '<i class="eg flag"></i>'
    when "Western Sahara"
      html = '<i class="eh flag"></i>'
    when "Eritrea"
      html = '<i class="er flag"></i>'
    when "Spain"
      html = '<i class="es flag"></i>'
    when "Ethiopia"
      html = '<i class="et flag"></i>'
    when "European Union"
      html = '<i class="eu flag"></i>'
    when "Finland"
      html = '<i class="fi flag"></i>'
    when "Fiji"
      html = '<i class="fj flag"></i>'
    when "Falkland Islands"
      html = '<i class="fk flag"></i>'
    when "Micronesia"
      html = '<i class="fm flag"></i>'
    when "Faroe Islands"
      html = '<i class="fo flag"></i>'
    when "France"
      html = '<i class="fr flag"></i>'
    when "Gabon"
      html = '<i class="ga flag"></i>'
    when "England"
      html = '<i class="gb flag"></i>'
    when "Grenada"
      html = '<i class="gd flag"></i>'
    when "Georgia"
      html = '<i class="ge flag"></i>'
    when "French Guiana"
      html = '<i class="gf flag"></i>'
    when "Ghana"
      html = '<i class="gh flag"></i>'
    when "Gibraltar"
      html = '<i class="gi flag"></i>'
    when "Greenland"
      html = '<i class="gl flag"></i>'
    when "Gambia"
      html = '<i class="gm flag"></i>'
    when "Guinea"
      html = '<i class="gn flag"></i>'
    when "Guadeloupe"
      html = '<i class="gp flag"></i>'
    when "Equatorial Guinea"
      html = '<i class="gq flag"></i>'
    when "Greece"
      html = '<i class="gr flag"></i>'
    when "Sandwich Islands"
      html = '<i class="gs flag"></i>'
    when "Guatemala"
      html = '<i class="gt flag"></i>'
    when "Guam"
      html = '<i class="gu flag"></i>'
    when "Guinea-Bissau"
      html = '<i class="gw flag"></i>'
    when "Guyana"
      html = '<i class="gy flag"></i>'
    when "Hong Kong"
      html = '<i class="hk flag"></i>'
    when "Heard Island"
      html = '<i class="hm flag"></i>'
    when "Honduras"
      html = '<i class="hn flag"></i>'
    when "Croatia"
      html = '<i class="hr flag"></i>'
    when "Haiti"
      html = '<i class="ht flag"></i>'
    when "Hungary"
      html = '<i class="hu flag"></i>'
    when "Indonesia"
      html = '<i class="id flag"></i>'
    when "Ireland"
      html = '<i class="ie flag"></i>'
    when "Israel"
      html = '<i class="il flag"></i>'
    when "India"
      html = '<i class="in flag"></i>'
    when "Indian Ocean Territory"
      html = '<i class="io flag"></i>'
    when "Iraq"
      html = '<i class="iq flag"></i>'
    when "Iran"
      html = '<i class="ir flag"></i>'
    when "Iceland"
      html = '<i class="is flag"></i>'
    when "Italy"
      html = '<i class="it flag"></i>'
    when "Jamaica"
      html = '<i class="jm flag"></i>'
    when "Jordan"
      html = '<i class="jo flag"></i>'
    when "Japan"
      html = '<i class="jp flag"></i>'
    when "Kenya"
      html = '<i class="ke flag"></i>'
    when "Kyrgyzstan"
      html = '<i class="kg flag"></i>'
    when "Cambodia"
      html = '<i class="kh flag"></i>'
    when "Kiribati"
      html = '<i class="ki flag"></i>'
    when "Comoros"
      html = '<i class="km flag"></i>'
    when "Saint Kitts and Nevis"
      html = '<i class="kn flag"></i>'
    when "North Korea"
      html = '<i class="kp flag"></i>'
    when "South Korea"
      html = '<i class="kr flag"></i>'
    when "Kuwait"
      html = '<i class="kw flag"></i>'
    when "Cayman Islands"
      html = '<i class="ky flag"></i>'
    when "Kazakhstan"
      html = '<i class="kz flag"></i>'
    when "Laos"
      html = '<i class="la flag"></i>'
    when "Lebanon"
      html = '<i class="lb flag"></i>'
    when "Saint Lucia"
      html = '<i class="lc flag"></i>'
    when "Liechtenstein"
      html = '<i class="li flag"></i>'
    when "Sri Lanka"
      html = '<i class="lk flag"></i>'
    when "Liberia"
      html = '<i class="lr flag"></i>'
    when "Lesotho"
      html = '<i class="ls flag"></i>'
    when "Lithuania"
      html = '<i class="lt flag"></i>'
    when "Luxembourg"
      html = '<i class="lu flag"></i>'
    when "Latvia"
      html = '<i class="lv flag"></i>'
    when "Libya"
      html = '<i class="ly flag"></i>'
    when "Morocco"
      html = '<i class="ma flag"></i>'
    when "Monaco"
      html = '<i class="mc flag"></i>'
    when "Moldova"
      html = '<i class="md flag"></i>'
    when "Montenegro"
      html = '<i class="me flag"></i>'
    when "Madagascar"
      html = '<i class="mg flag"></i>'
    when "Marshall Islands"
      html = '<i class="mh flag"></i>'
    when "MacEdonia"
      html = '<i class="mk flag"></i>'
    when "Mali"
      html = '<i class="ml flag"></i>'
    when "Burma"
      html = '<i class="ar flag"></i>'
    when "Mongolia"
      html = '<i class="mn flag"></i>'
    when "MacAu"
      html = '<i class="mo flag"></i>'
    when "Northern Mariana Islands"
      html = '<i class="mp flag"></i>'
    when "Martinique"
      html = '<i class="mq flag"></i>'
    when "Mauritania"
      html = '<i class="mr flag"></i>'
    when "Montserrat"
      html = '<i class="ms flag"></i>'
    when "Malta"
      html = '<i class="mt flag"></i>'
    when "Mauritius"
      html = '<i class="mu flag"></i>'
    when "Maldives"
      html = '<i class="mv flag"></i>'
    when "Malawi"
      html = '<i class="mw flag"></i>'
    when "Mexico"
      html = '<i class="mx flag"></i>'
    when "Malaysia"
      html = '<i class="my flag"></i>'
    when "Mozambique"
      html = '<i class="mz flag"></i>'
    when "Namibia"
      html = '<i class="na flag"></i>'
    when "New Caledonia"
      html = '<i class="nc flag"></i>'
    when "Niger"
      html = '<i class="ne flag"></i>'
    when "Norfolk Island"
      html = '<i class="nf flag"></i>'
    when "Nigeria"
      html = '<i class="ng flag"></i>'
    when "Nicaragua"
      html = '<i class="ni flag"></i>'
    when "Netherlands"
      html = '<i class="nl flag"></i>'
    when "Norway"
      html = '<i class="no flag"></i>'
    when "Nepal"
      html = '<i class="np flag"></i>'
    when "Nauru"
      html = '<i class="nr flag"></i>'
    when "Niue"
      html = '<i class="nu flag"></i>'
    when "New Zealand"
      html = '<i class="nz flag"></i>'
    when "Oman"
      html = '<i class="om flag"></i>'
    when "Panama"
      html = '<i class="pa flag"></i>'
    when "Peru"
      html = '<i class="pe flag"></i>'
    when "French Polynesia"
      html = '<i class="pf flag"></i>'
    when "New Guinea"
      html = '<i class="pg flag"></i>'
    when "Philippines"
      html = '<i class="ph flag"></i>'
    when "Pakistan"
      html = '<i class="pk flag"></i>'
    when "Poland"
      html = '<i class="pl flag"></i>'
    when "Saint Pierre"
      html = '<i class="pm flag"></i>'
    when "Pitcairn Islands"
      html = '<i class="pn flag"></i>'
    when "Puerto Rico"
      html = '<i class="pr flag"></i>'
    when "Palestine"
      html = '<i class="ps flag"></i>'
    when "Portugal"
      html = '<i class="pt flag"></i>'
    when "Palau"
      html = '<i class="pw flag"></i>'
    when "Paraguay"
      html = '<i class="py flag"></i>'
    when "Qatar"
      html = '<i class="qa flag"></i>'
    when "Reunion"
      html = '<i class="re flag"></i>'
    when "Romania"
      html = '<i class="ro flag"></i>'
    when "Serbia"
      html = '<i class="rs flag"></i>'
    when "Russia"
      html = '<i class="ru flag"></i>'
    when "Rwanda"
      html = '<i class="rw flag"></i>'
    when "Saudi Arabia"
      html = '<i class="sa flag"></i>'
    when "Solomon Islands"
      html = '<i class="sb flag"></i>'
    when "Seychelles"
      html = '<i class="sc flag"></i>'
    when "Sudan"
      html = '<i class="sd flag"></i>'
    when "Sweden"
      html = '<i class="se flag"></i>'
    when "Singapore"
      html = '<i class="sg flag"></i>'
    when "Saint Helena"
      html = '<i class="sh flag"></i>'
    when "Slovenia"
      html = '<i class="si flag"></i>'
    when "Svalbard, I Flag Jan Mayen"
      html = '<i class="sj flag"></i>'
    when "Slovakia"
      html = '<i class="sk flag"></i>'
    when "Sierra Leone"
      html = '<i class="sl flag"></i>'
    when "San Marino"
      html = '<i class="sm flag"></i>'
    when "Senegal"
      html = '<i class="sn flag"></i>'
    when "Somalia"
      html = '<i class="so flag"></i>'
    when "Suriname"
      html = '<i class="sr flag"></i>'
    when "Sao Tome"
      html = '<i class="st flag"></i>'
    when "El Salvador"
      html = '<i class="sv flag"></i>'
    when "Syria"
      html = '<i class="sy flag"></i>'
    when "Swaziland"
      html = '<i class="sz flag"></i>'
    when "Caicos Islands"
      html = '<i class="tc flag"></i>'
    when "Chad"
      html = '<i class="td flag"></i>'
    when "French Territories"
      html = '<i class="tf flag"></i>'
    when "Togo"
      html = '<i class="tg flag"></i>'
    when "Thailand"
      html = '<i class="th flag"></i>'
    when "Tajikistan"
      html = '<i class="tj flag"></i>'
    when "Tokelau"
      html = '<i class="tk flag"></i>'
    when "Timorleste"
      html = '<i class="tl flag"></i>'
    when "Turkmenistan"
      html = '<i class="tm flag"></i>'
    when "Tunisia"
      html = '<i class="tn flag"></i>'
    when "Tonga"
      html = '<i class="to flag"></i>'
    when "Turkey"
      html = '<i class="tr flag"></i>'
    when "Trinidad"
      html = '<i class="tt flag"></i>'
    when "Tuvalu"
      html = '<i class="tv flag"></i>'
    when "Taiwan"
      html = '<i class="tw flag"></i>'
    when "Tanzania"
      html = '<i class="tz flag"></i>'
    when "U.A.E"
      html = '<i class="ae flag"></i>'
    when "Ukraine"
      html = '<i class="ua flag"></i>'
    when "Uganda"
      html = '<i class="ug flag"></i>'
    when "Us Minor Islands"
      html = '<i class="um flag"></i>'
    when "United States"
      html = '<i class="us flag"></i>'
    when "Uruguay"
      html = '<i class="uy flag"></i>'
    when "Uzbekistan"
      html = '<i class="uz flag"></i>'
    when "Vatican City"
      html = '<i class="va flag"></i>'
    when "Saint Vincent"
      html = '<i class="vc flag"></i>'
    when "Venezuela"
      html = '<i class="ve flag"></i>'
    when "British Virgin Islands"
      html = '<i class="vg flag"></i>'
    when "Us Virgin Islands"
      html = '<i class="vi flag"></i>'
    when "Vietnam"
      html = '<i class="vn flag"></i>'
    when "Vanuatu"
      html = '<i class="vu flag"></i>'
    when "Wallis and Futuna"
      html = '<i class="wf flag"></i>'
    when "Samoa"
      html = '<i class="ws flag"></i>'
    when "Yemen"
      html = '<i class="ye flag"></i>'
    when "Mayotte"
      html = '<i class="yt flag"></i>'
    when "South Africa"
      html = '<i class="za flag"></i>'
    when "Zambia"
      html = '<i class="zm flag"></i>'
    when "Zimbabwe"
      html = '<i class="zw flag"></i>'
    else
      html = 'Select Country'
    end

    return html
  end

end
