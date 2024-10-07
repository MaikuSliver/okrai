import 'okra.dart';

class OkraList {
  List<okra> okraList = [

okra(// 0 Mild Early Blight Disease
  hstatus: 'Diseased', 
  water: 'Every 2 weeks', 
  fertilization: 'Every 2 Days', 
  description: 'Leaf spots of early blight are circular, up to 12 mm in diameter, '
               'brown, and often show a circular pattern, which distinguishes this '
               'disease from other leaf spots on Okra.', 
  whattodo:  "\u2022 Use resistant varieties (e.g. Rio Grande).\n"
             "\u2022 Use certified disease-free seeds. If using own seeds, hot water treat the seeds.\n"
             "\u2022 Use disease-free plants.\n"
             "\u2022 Do not plant okra crops consecutively on the same land.\n"
             "\u2022 Practise rotation with non-solanaceous crops (e.g. brassicas, legumes, small grains).\n"
             "\u2022 Stake and prune indeterminate varieties.\n"
             "\u2022 If disease is endemic, apply preventative sprays of copper compounds (e.g. copper hydroxide).", 
  pest: "Fungal", 
  treatment: 'For best control, apply copper-based fungicides '
            'early, two weeks before disease normally appears or when weather '
            'forecasts predict a long period of wet weather. Alternatively, begin '
            'treatment when disease first appears, and repeat every 7-10 days for as long as needed.',
  progress: 0.73), 

okra(// 1 Severe Early Blight Disease
  hstatus: 'Diseased', 
  water: 'Every 10 days', 
  fertilization: 'Every 3 Days', 
  description: 'In severe cases, large portions of leaves turn yellow and brown, '
               'leading to premature leaf drop, significantly reducing photosynthesis.', 
  whattodo:  "\u2022 Remove affected leaves and destroy them.\n"
             "\u2022 Avoid overhead watering to reduce moisture on leaves.\n"
             "\u2022 Ensure good air circulation around plants.\n"
             "\u2022 Increase fungicide application frequency if weather conditions favor disease spread.",
  pest: "Fungal", 
  treatment: 'Use systemic fungicides such as chlorothalonil or mancozeb to stop the spread. '
             'Apply every 7 days until symptoms subside.',
  progress: 0.43),

okra(// 2 Critical Early Blight Disease
  hstatus: 'Diseased', 
  water: 'Every 5 days', 
  fertilization: 'Every 5 Days', 
  description: 'Leaves are almost entirely defoliated, plant growth is stunted, and fruit production is severely reduced.',
  whattodo:  "\u2022 Consider replacing plants if severely affected.\n"
             "\u2022 Sanitize tools and hands to avoid further spread.\n"
             "\u2022 Apply fungicides with higher efficacy, such as azoxystrobin or difenoconazole.",
  pest: "Fungal", 
  treatment: 'Fungicides may no longer be effective. Focus on removing severely infected plants and improving growing conditions to reduce humidity.',
  progress: 0.04),

okra(// 3 Mild Leaf Curl Disease
  hstatus: 'Diseased', 
  water: 'Every 2 weeks', 
  fertilization: 'Every 10 Days', 
  description: 'Mild curling of leaves with slight yellowing along the veins, mostly affecting younger leaves.', 
  whattodo:  "\u2022 Remove affected leaves.\n"
             "\u2022 Monitor for pests like whiteflies, as they may be vectors.\n"
             "\u2022 Use yellow sticky traps to capture whiteflies.\n"
             "\u2022 Ensure adequate potassium levels in the soil.",
  pest: "Viral (Transmitted by whiteflies)", 
  treatment: 'Apply neem oil or insecticidal soap to manage whiteflies. Consider using virus-resistant varieties in future plantings.',
  progress: 0.5),

okra(// 4 Severe Leaf Curl Disease
  hstatus: 'Diseased', 
  water: 'Every 7 days', 
  fertilization: 'Every 5 Days', 
  description: 'Severe curling and distortion of leaves, plants exhibit stunted growth, and yield is reduced.', 
  whattodo:  "\u2022 Use reflective mulches to repel whiteflies.\n"
             "\u2022 Remove infected plants to limit disease spread.\n"
             "\u2022 Avoid planting okra next to highly susceptible crops (e.g., tomatoes).",
  pest: "Viral (Whiteflies)", 
  treatment: 'Apply insecticides like imidacloprid to manage the vector population. Frequent application may be necessary in heavily infested areas.',
  progress: 0.25),

okra(// 5 Critical Leaf Curl Disease
  hstatus: 'Diseased', 
  water: 'Every 4 days', 
  fertilization: 'Every 7 Days', 
  description: 'Plants are severely stunted with almost no healthy foliage. Leaves are thickened and malformed.', 
  whattodo:  "\u2022 Remove and destroy infected plants immediately.\n"
             "\u2022 Ensure neighboring crops are also treated for whiteflies.\n"
             "\u2022 Consider crop rotation to break the pest cycle.",
  pest: "Viral (Whiteflies)", 
  treatment: 'Management may no longer be effective. Focus on vector control and replanting with resistant varieties.',
  progress: 0.1),

okra(// 6 Mild Yellow Vein Mosaic Disease
  hstatus: 'Diseased', 
  water: 'Every 2 weeks', 
  fertilization: 'Every 12 Days', 
  description: 'Light yellowing of veins and mild chlorosis of young leaves. Symptoms may spread slowly.', 
  whattodo:  "\u2022 Prune affected areas.\n"
             "\u2022 Apply organic insecticides to reduce whitefly populations.\n"
             "\u2022 Increase nutrient availability to help plants recover.",
  pest: "Viral (Whiteflies)", 
  treatment: 'Spray insecticidal soap or neem oil at early stages of whitefly infestations. Apply foliar feed to boost plant health.',
  progress: 0.5),

okra(// 7 Severe Yellow Vein Mosaic Disease
  hstatus: 'Diseased', 
  water: 'Every 5 days', 
  fertilization: 'Every 3 Days', 
  description: 'Yellowing extends from veins to leaf blades. Plants show significant reduction in growth.', 
  whattodo:  "\u2022 Increase insecticide application to control whiteflies.\n"
             "\u2022 Use virus-free seedlings.\n"
             "\u2022 Consider early harvesting of mildly infected crops to salvage some yield.",
  pest: "Viral (Whiteflies)", 
  treatment: 'Apply systemic insecticides like acetamiprid to reduce whitefly transmission. Remove and destroy infected plants to reduce viral spread.',
  progress: 0.2),

okra(// 8 Critical Yellow Vein Mosaic Disease
  hstatus: 'Diseased', 
  water: 'Every 3 days', 
  fertilization: 'Every 6 Days', 
  description: 'Severe chlorosis, reduced leaf size, and poor fruit set. Yield is significantly impacted.', 
  whattodo:  "\u2022 Remove and burn infected plants.\n"
             "\u2022 Use integrated pest management strategies, including reflective mulch and beneficial insects.",
  pest: "Viral (Whiteflies)", 
  treatment: 'Control efforts may be ineffective. Focus on preventing disease in future seasons through resistant varieties and vector control.',
  progress: 0.05),

okra(// 9 Healthy
  hstatus: 'Healthy', 
  water: 'Every 10 days', 
  fertilization: 'Every 14 Days', 
  description: 'Healthy okra plant with no visible signs of disease or pests.', 
  whattodo:  "\u2022 Continue regular care including balanced watering and fertilization.\n"
             "\u2022 Monitor for pests and diseases regularly.\n"
             "\u2022 Prune older leaves to promote airflow and reduce fungal risk.",
  pest: "None", 
  treatment: 'No treatment needed. Keep monitoring for potential disease or pest problems.',
  progress: 1.0),
  ];
}
