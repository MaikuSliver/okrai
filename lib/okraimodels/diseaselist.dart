import 'disease.dart';

class DiseaseList {
  List<disease> diseaseList = [

    disease( // 0 Yellow Vein Disease
      mainimage: "assets/images/dis2.png", 
      name:  "Yellow Vein Disease", 
      scientific: "Vein-Clearing/Yellow Vein Mosaic", 
      scientific2: "Bhendi yellow vein mosaic virus", 
      image1: 'assets/images/y1.jpg', 
      image2: 'assets/images/y2.jpg', 
      image3: 'assets/images/y3.jpg', 
      image4: 'assets/images/y4.jpg',
      symptom: "\u2022 Yellowing of the entire network of veins in the leaf blade is the characteristic symptom.\n"
               "\u2022 In severe infections, younger leaves turn yellow, become reduced in size, and the plant becomes highly stunted.\n"
               "\u2022 The veins of the leaves will be cleared by the virus and intervenal areas become completely yellow or white.\n"
               "\u2022 Infection restricts flowering and fruit development; fruits, if formed, may be smaller and harder.\n"
               "\u2022 The affected plants produce fruits with yellow or white color, which are not fit for marketing.\n"
               "\u2022 The virus is spread by whiteflies.", 
      farmuse: "\u2022 Spray azadirachtin 0.03 WSP @ 5 g/10l or methyl demeton 25 EC @ 1.6 ml/l or thiamethoxam 25 WG @ 2 g/l to kill the insect vector (whitefly).\n"
               "\u2022 Select resistant varieties like Parbhani Kranti, Arka Abhay, Arka Anamika, and Varsha Uphar to minimize disease incidence.\n"
               "\u2022 Avoid sowing susceptible varieties during the summer season when whitefly activity is high.\n"
               "\u2022 Do not use synthetic pyrethroids as they may aggravate the situation.\n"
               "\u2022 Control the virus with Chlorpyriphos 2.5 ml + neem oil 2 ml per liter of water."
    ),

    disease( // 1 Leaf Curl Disease
      mainimage: "assets/images/c4.jpg",  
      name:   "Enation Leaf Curl Disease", 
      scientific: "Geminiviridae, Genus:", 
      scientific2: "Begomovirus", 
      image1: "assets/images/c2.jpg", 
      image2: "assets/images/c3.jpg", 
      image3: "assets/images/c4.jpg", 
      image4: "assets/images/c5.jpg", 
      symptom: "\u2022 Plants are stunted or dwarfed.\n"
               "\u2022 New growth is reduced in size after infection.\n"
               "\u2022 Leaflets are rolled upwards and inwards, and leaves are often bent downwards, becoming leathery and thick.\n"
               "\u2022 Interveinal chlorosis and wrinkling are commonly observed.\n"
               "\u2022 Fruits, if produced, are small, dry, and unsaleable.\n"
               "\u2022 Affected plants tend to be distributed randomly or in patches.", 
      farmuse: "\u2022 Use virus-free seedlings grown in areas free from whiteflies.\n"
               "\u2022 Destroy old crops after harvest to prevent virus spread.\n"
               "\u2022 Control whiteflies using appropriate chemicals and IPM strategies.\n"
               "\u2022 Avoid synthetic pyrethroids as they can worsen the situation.\n"
               "\u2022 Apply Chlorpyriphos 2.5 ml + neem oil 2 ml per liter of water."
    ),

    disease( // 2 Early Blight
      mainimage: "assets/images/e1.jpg", 
      name:   "Early Blight Disease", 
      scientific: "Alternaria solani", 
      scientific2: "Alternaria tomatophila and Alternaria solani virus", 
      image1: "assets/images/e5.jpg", 
      image2: "assets/images/e3.jpg", 
      image3: "assets/images/e2.jpg", 
      image4: "assets/images/e4.jpg", 
      symptom: "\u2022 Leaf symptoms of early blight are large, irregular patches of black, necrotic tissue surrounded by larger yellow areas.\n"
               "\u2022 The spots have a characteristic concentric banding appearance (oyster-shell or bull's eye).", 
      farmuse: "Minimize wetting of leaves by using drip or furrow irrigation. Infection occurs rapidly in warm, wet weather.\n"
               "Fungicide sprays can control the disease effectively."
    ),

    disease( // 3 Powdery Mildew
      mainimage: 'assets/images/images (5).jpg',
      name:   "Powdery Mildew", 
      scientific: "Erysiphe cichoracearum", 
      scientific2: "Podosphaera xanthii", 
      image1: "assets/images/p1.jpg", 
      image2: "assets/images/p2.jpg", 
      image3: "assets/images/p3.jpg", 
      image4: "assets/images/p4.jpg", 
      symptom: "\u2022 White, powdery spots appear on leaves, stems, and flowers.\n"
               "\u2022 Affected leaves may become distorted and drop prematurely.\n"
               "\u2022 Severe infections reduce photosynthesis, impacting plant growth.", 
      farmuse: "\u2022 Apply sulfur or potassium bicarbonate-based fungicides at early signs of the disease.\n"
               "\u2022 Improve air circulation and avoid overhead watering to reduce humidity."
    ),

    disease( // 4 Fusarium Wilt
      mainimage: "assets/images/picture2.jpg", 
      name:   "Fusarium Wilt", 
      scientific: "Fusarium oxysporum", 
      scientific2: "F. oxysporum f. sp. vasinfectum", 
      image1: "assets/images/f1.jpg", 
      image2: "assets/images/f2.jpg", 
      image3: "assets/images/f3.jpg", 
      image4: "assets/images/f4.jpg", 
      symptom: "\u2022 Leaves wilt and turn yellow, starting from the lower parts of the plant.\n"
               "\u2022 Plants may show stunted growth and premature death.\n"
               "\u2022 The disease is more severe in warm temperatures.", 
      farmuse: "\u2022 Use resistant varieties and practice crop rotation.\n"
               "\u2022 Remove and destroy infected plants to reduce soil contamination."
    ),

    disease( // 5 Leaf Spot
      mainimage: "assets/images/images (6).jpg", 
      name:   "Leaf Spot", 
      scientific: "Cercospora abelmoschi", 
      scientific2: "Cercospora spp.", 
      image1: "assets/images/l1.jpg", 
      image2: "assets/images/l2.jpg", 
      image3: "assets/images/l3.jpg", 
      image4: "assets/images/l4.jpg", 
      symptom: "\u2022 Small, brown or black spots with a yellow halo appear on leaves.\n"
               "\u2022 In severe cases, the spots merge, causing leaves to die and drop.", 
      farmuse: "\u2022 Avoid overhead irrigation to minimize leaf wetness.\n"
               "\u2022 Apply copper-based fungicides to prevent the spread of the disease."
    ),

    disease( // 6 Silverleaf Whitefly
      mainimage: "assets/images/images (7).jpg", 
      name:   "Silverleaf Whitefly", 
      scientific: "Bemisia tabaci", 
      scientific2: "Bemisia argentifolii", 
       image1: "assets/images/s1.jpg", 
      image2: "assets/images/s2.jpg", 
      image3: "assets/images/s3.jpg", 
      image4: "assets/images/s4.jpg", 
      symptom: "\u2022 Whiteflies feed on plant sap, causing leaves to yellow and drop.\n"
               "\u2022 Plants may become stunted, and fruit production is reduced.", 
      farmuse: "\u2022 Use yellow sticky traps to monitor and control whitefly populations.\n"
               "\u2022 Apply insecticidal soap or neem oil to control infestations."
    ),

    disease( // 7 Corythucha Gossypii
      mainimage: "assets/images/images (8).jpg", 
      name:   "Corythucha Gossypii", 
      scientific: "Corythucha gossypii", 
      scientific2: "Lace Bug", 
       image1: "assets/images/cc1.jpg", 
      image2: "assets/images/cc2.jpg", 
      image3: "assets/images/cc3.jpg", 
      image4: "assets/images/cc4.jpg", 
      symptom: "\u2022 Leaves develop yellow spots and may appear bronzed or scorched.\n"
               "\u2022 Heavy infestations cause leaf drop and reduced plant vigor.", 
      farmuse: "\u2022 Use horticultural oils or insecticidal soap to manage lace bug populations.\n"
               "\u2022 Maintain healthy plants to minimize damage."
    ),

    disease( // 8 Anthracnose
      mainimage: "assets/images/images (9).jpg", 
      name:   "Anthracnose", 
      scientific: "Colletotrichum spp.", 
      scientific2: "Colletotrichum malvarum", 
       image1: "assets/images/a1.jpg", 
      image2: "assets/images/a2.jpg", 
      image3: "assets/images/a3.jpg", 
      image4: "assets/images/a4.jpg",  
      symptom: "\u2022 Dark, sunken lesions appear on leaves, stems, and fruits.\n"
               "\u2022 Infected fruits may rot and drop prematurely.", 
      farmuse: "\u2022 Use resistant varieties and rotate crops to reduce disease pressure.\n"
               "\u2022 Apply fungicides containing copper to manage the disease."
    ),

    disease( // 9 Aphids
      mainimage: "assets/images/images (10).jpg", 
      name:   "Aphids", 
      scientific: "Aphidoidea", 
      scientific2: "Aphis gossypii", 
       image1: "assets/images/ap1.jpg", 
      image2: "assets/images/ap2.jpg", 
      image3: "assets/images/ap3.png", 
      image4: "assets/images/ap4.jpg",  
      symptom: "\u2022 Aphids cluster on new growth, sucking sap and causing leaf curling.\n"
               "\u2022 Heavy infestations result in stunted plants and distorted leaves.", 
      farmuse: "\u2022 Use insecticidal soap or neem oil to control aphid populations.\n"
               "\u2022 Encourage natural predators such as ladybugs and lacewings."
    ),

    disease( // 10 Damping Off
      mainimage: "assets/images/images (4).jpg", 
      name:   "Damping Off", 
      scientific: "Pythium spp.", 
      scientific2: "Rhizoctonia solani", 
       image1: "assets/images/d1.jpg", 
      image2: "assets/images/d2.jpg", 
      image3: "assets/images/d3.jpg", 
      image4: "assets/images/d4.png", 
      symptom: "\u2022 Seedlings collapse and die shortly after germination.\n"
               "\u2022 Infected plants have water-soaked lesions at the soil line.", 
      farmuse: "\u2022 Use sterilized soil and practice good sanitation to prevent damping off.\n"
               "\u2022 Apply fungicides to protect seedlings from infection."
    ),

    disease( // 11 Root Rot
      mainimage: "assets/images/images (11).jpg", 
      name:   "Root Rot", 
      scientific: "Fusarium spp.", 
      scientific2: "Phytophthora spp.", 
       image1: "assets/images/r1.jpg", 
      image2: "assets/images/r2.jpg", 
      image3: "assets/images/r3.jpg", 
      image4: "assets/images/r4.jpg", 
      symptom: "\u2022 Plants wilt and show yellowing of leaves, starting from the lower part.\n"
               "\u2022 Roots are discolored and rotted, leading to plant death.", 
      farmuse: "\u2022 Improve soil drainage and avoid overwatering to reduce root rot.\n"
               "\u2022 Use fungicide treatments if necessary."
    ),

  ];
}

  
 

    
    
