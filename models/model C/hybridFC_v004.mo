model hybridFC_v004
  PowerSystems.AC1ph_DC.Sources.DCvoltage voltage1(pol = 0, puUnits = false, use_vDC_in = true) annotation(
    Placement(visible = true, transformation(origin = {-196, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Nodes.GroundOne ground annotation(
    Placement(visible = true, transformation(origin = {-228, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter fcMeter (puUnits = false) annotation(
    Placement(visible = true, transformation(origin = {-168, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  simpleFC fc annotation(
    Placement(visible = true, transformation(origin = {-196, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.InverterAverage inverter(redeclare record Data = PowerSystems.Examples.Data.Semiconductors.IdealSC100V_10A) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.Select select annotation(
    Placement(visible = true, transformation(origin = {0, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Blocks.Signals.TransientPhasor phasor annotation(
    Placement(visible = true, transformation(origin = {-22, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PowerSystems.System system annotation(
    Placement(visible = true, transformation(origin = {-2, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sensors.PVImeter ACMeter(puUnits = false) annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sources.PQsource pQsource1(pq0 = {10000, 0}, puUnits = false, use_pq_in = true) annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_up(duration = 30, height = -990, offset = -10, startTime = 600)  annotation(
    Placement(visible = true, transformation(origin = {38, 66}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Sources.Step step(height = 400, startTime = 690)  annotation(
    Placement(visible = true, transformation(origin = {54, 80}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Math.Add3 add annotation(
    Placement(visible = true, transformation(origin = {54, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp_down(duration = 30, height = 590, startTime = 3090)  annotation(
    Placement(visible = true, transformation(origin = {70, 68}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  PowerSystems.AC1ph_DC.Nodes.BusBar bus annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-28, -26}, {28, 26}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter busMeter(puUnits = false)  annotation(
    Placement(visible = true, transformation(origin = {-28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter boostedFCMeter(puUnits = false)  annotation(
    Placement(visible = true, transformation(origin = {-110, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Inverters.ChopperAverage fcBooster annotation(
    Placement(visible = true, transformation(origin = {-138, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond1 annotation(
    Placement(visible = true, transformation(origin = {-138, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Blocks.Signals.Transient transSig1(s_end = 2, s_start = 0, t_change = 0, t_duration = 0.001)  annotation(
    Placement(visible = true, transformation(origin = {-132, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerSystems.AC1ph_DC.Nodes.GroundOne ground2 annotation(
    Placement(visible = true, transformation(origin = {-228, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Inverters.ChopperAverage batbooster annotation(
    Placement(visible = true, transformation(origin = {-138, -18}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter boostedBatMeter(puUnits = false)  annotation(
    Placement(visible = true, transformation(origin = {-110, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond2 annotation(
    Placement(visible = true, transformation(origin = {-138, -40}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerSystems.Blocks.Signals.Transient transSig2(s_end = 2, s_start = 0, t_change = 0, t_duration = 0.001) annotation(
    Placement(visible = true, transformation(origin = {-132, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter batteryMeter(puUnits = false)  annotation(
    Placement(visible = true, transformation(origin = {-168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PSBatteryStack pSBatteryStack(cellData = cellData, Ns = 10, Np = 2, SOC(start = 1, fixed = true))  annotation(
    Placement(transformation(origin = {-196, -18}, extent = {{-10, -10}, {10, 10}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData(Qnom = 9360, useLinearSOCDependency = false, OCVmax = 3.53875246351611, Ri = 0.001, OCV_SOC = [0.000401639263894638, 0.736960234695056; 0.000530585837060185, 0.7394686448806302; 0.00104637212972238, 0.7416635037930117; 0.00130426527605346, 0.7424996405215355; 0.001433211849219, 0.7430222259768636; 0.00156215842238455, 0.7437538456143241; 0.0016911049955501, 0.7445899823428508; 0.00220689128821228, 0.7457396703445731; 0.00226131007254175, 0.7434730838303272; 0.00246478443454337, 0.7465758070730969; 0.00266943198272188, 0.7476735789778236; 0.00298057072720555, 0.7475164608926897; 0.00323846387353664, 0.7490842172586741; 0.00336741044670219, 0.7507564907157246; 0.00362530359303329, 0.7520106958085132; 0.00439898303202656, 0.7536829692655636; 0.00452798174035113, 0.752680613599379; 0.00478582275152319, 0.7569229990885984; 0.00491476932468873, 0.7551462085404818; 0.0049619544780055, 0.7561282329589026; 0.00504371589785428, 0.7554597598136803; 0.00530160904418538, 0.7573410674528632; 0.00543055561735092, 0.7602675460027022; 0.00550420533495305, 0.7602740920318916; 0.00581739533684755, 0.7616262681865542; 0.00633318162950974, 0.7626714390972102; 0.00659107477584082, 0.7642391954631974; 0.00684896792217192, 0.7651798492827875; 0.0073647542148341, 0.7662250201934436; 0.00749370078799964, 0.7671656740130365; 0.00752420447848019, 0.7655919931547894; 0.00752882837856918, 0.7691107933726712; 0.00800948708066183, 0.7686289132879546; 0.00833919375230464, 0.7730382702123738; 0.00865421994648956, 0.7713463576556641; 0.00878316651965511, 0.7723915285663203; 0.00891211309282065, 0.7738547678412384; 0.00904105966598619, 0.7750044558429608; 0.00942789938548283, 0.7774083489374718; 0.00981473910497947, 0.7790806223945224; 0.00982199606921407, 0.7780564427329872; 0.00994368567814501, 0.7823206522175599; 0.0099616450207389, 0.7822025449030843; 0.0100726322513106, 0.7836793744014119; 0.0103305253976417, 0.7851426136763328; 0.0107173651171383, 0.7862923016780551; 0.0109752582634694, 0.7883826434993676; 0.011362097982966, 0.7914136391402727; 0.0115832360286915, 0.7907121590881406; 0.0115886126567019, 0.7948037872484679; 0.0116199911292971, 0.79392204932585; 0.0118778842756282, 0.7972665962399509; 0.0121357774219593, 0.7988343526059352; 0.0125226171414559, 0.8022834166111024; 0.0126515637146215, 0.8067776515269256; 0.0129094568609526, 0.8076137882554524; 0.0132046119715237, 0.7990581081467856; 0.0132168706833875, 0.8083870203523312; 0.0132962965804492, 0.8122125402623419; 0.0134252431536148, 0.8130486769908685; 0.0135541897267803, 0.8141983649925908; 0.0136130206351977, 0.8034768234628332; 0.0138120828731114, 0.8153480529943133; 0.0140274511222434, 0.8124781623184482; 0.014198922592608, 0.81900615118161; 0.0143278691657736, 0.81712484354243; 0.0144568157389391, 0.8193197024548086; 0.0149726020316013, 0.8220371468225152; 0.0156494722604368, 0.82131510675633; 0.0157462814705946, 0.8246500740991586; 0.0158752280437601, 0.8274720355579315; 0.0162620677632567, 0.8328024072022815; 0.0164603752969733, 0.8256517464120667; 0.0165199609095878, 0.8338475781129376; 0.0167778540559189, 0.8355198515699881; 0.0169068006290845, 0.837401159209171; 0.0172766549615203, 0.834080014228128; 0.0172936403485811, 0.8389689155751553; 0.0174225869217466, 0.8414773257607324; 0.0176804800680778, 0.8428360479445843; 0.0176849202484473, 0.8383896194599013; 0.0178094266412433, 0.8441947701284391; 0.0179383732144088, 0.8454489752212276; 0.0180939024191091, 0.8432447751130517; 0.0181962663607399, 0.8469122144961457; 0.0183252129339055, 0.847957385406802; 0.0185831060802366, 0.8490025563174609; 0.0188409992265677, 0.8501522443191833; 0.0190988923728987, 0.850883863956641; 0.0193567855192298, 0.8511974152298395; 0.0197436252387265, 0.8521380690494296; 0.0205173046777198, 0.8524516203226281; 0.0205213424332684, 0.8522448984831374; 0.0211620375435475, 0.8528696886868901; 0.0223225567020374, 0.8531832399600857; 0.0225804498483685, 0.8536013083243505; 0.0234830758605273, 0.8540193766886124; 0.024127808726355, 0.8540193766886124; 0.0250304347385138, 0.8547509963260729; 0.0253575117961105, 0.856006279225368; 0.0301923907682302, 0.8587856692091216; 0.0350279149357111, 0.8620560545721149; 0.0398633674148185, 0.8652718848929712; 0.044698676517179, 0.8683786051295533; 0.0495336988660456, 0.8712671051975811; 0.0543683627730448, 0.8738828300549233; 0.0592028833032971, 0.8763894448279884; 0.0640375472102963, 0.8790051696853278; 0.0688726412475364, 0.8819482247954956; 0.0737070900894152, 0.8844002845264236; 0.0785413238661736, 0.8866886791309402; 0.0833757727080524, 0.8891407388618681; 0.0882097197313169, 0.8912109132978305; 0.0930438818197019, 0.8934447528602072; 0.097877470401099, 0.8952421520854839; 0.102710843917376, 0.8968758861843463; 0.107544647563893, 0.8988369505360345; 0.11237780601505, 0.9003070195084828; 0.117210749401085, 0.9016134233545197; 0.122043119280134, 0.9024833868634539; 0.126875345782435, 0.9032442402881138; 0.131707572284736, 0.9040050937127737; 0.136539798787037, 0.9047659471374336; 0.141372025289338, 0.9055268005620908; 0.146203965038145, 0.9060694338181994; 0.151035761410206, 0.9065029569900337; 0.15586784453576, 0.9071547003304165; 0.16069964090782, 0.9075882235022508; 0.165531724033375, 0.9082399668426336; 0.170363663782182, 0.9087826000987423; 0.175195245089122, 0.9090524581441624; 0.180027041461182, 0.9094859813159967; 0.184858694456495, 0.9098103944035538; 0.18969077758205, 0.9104621377439395; 0.194522430577363, 0.9107865508314967; 0.199354298637797, 0.9112746290454682; 0.204186166698231, 0.9117627072594369; 0.209018393200532, 0.9125235606840968; 0.213849831130725, 0.9126843086452426; 0.218681484126038, 0.9130087217327998; 0.223513208809725, 0.9133876898624942; 0.228344790116665, 0.9136575479079143; 0.233176371423605, 0.9139274059533343; 0.238008454549159, 0.9145791492937201; 0.242840035856099, 0.9148490073391402; 0.247671688851412, 0.9151734204266972; 0.252503700288593, 0.9157706087249431; 0.257335568349027, 0.9162586869389144; 0.262167651474581, 0.9169104302792973; 0.266999089404774, 0.9170711782404432; 0.271830957465208, 0.9175592564544146; 0.27666218033028, 0.9175563392891462; 0.281494191767461, 0.918153527587392; 0.286326059827895, 0.9186416058013633; 0.291158142953449, 0.9192933491417462; 0.295989795948763, 0.9196177622293035; 0.300821305567329, 0.9198330652325863; 0.305652743497522, 0.9199938131937322; 0.310484253116088, 0.9202091161970124; 0.315316264553269, 0.9208063044952581; 0.320147487418342, 0.9208033873299897; 0.324978925348535, 0.9209641352911355; 0.329810793408968, 0.921452213505107; 0.334642446404282, 0.9217766265926642; 0.339473740957728, 0.9218282644695329; 0.344305465641415, 0.9222072325992301; 0.349137333701848, 0.9226953108131988; 0.353968915008788, 0.9229651688586188; 0.358800496315728, 0.9232350269040389; 0.363632364376162, 0.9237231051180104; 0.368463873994728, 0.9239384081212935; 0.373295455301668, 0.9242082661667135; 0.378127323362102, 0.9246963443806848; 0.382958546227175, 0.9246934272154165; 0.387790127534115, 0.9249632852608366; 0.392621852217801, 0.925342253390531; 0.397453075082874, 0.9253393362252625; 0.402284297947947, 0.9253364190599942; 0.40711595094326, 0.9256608321475515; 0.411947173808332, 0.925657914982283; 0.416778396673405, 0.9256549978170147; 0.421609619538478, 0.9256520806517463; 0.42644084240355, 0.9256491634864779; 0.431272065268623, 0.9256462463212095; 0.436103288133695, 0.9256433291559412; 0.440934510998768, 0.9256404119906727; 0.44576573386384, 0.9256374948254044; 0.450596956728913, 0.9256345776601358; 0.455428179593985, 0.9256316604948674; 0.460259402459058, 0.9256287433295991; 0.46509062532413, 0.9256258261643306; 0.469921848189203, 0.9256229089990623; 0.474753071054275, 0.925619991833794; 0.479584293919348, 0.9256170746685255; 0.484415516784421, 0.9256141575032572; 0.489246739649493, 0.9256112403379888; 0.494077962514566, 0.9256083231727203; 0.498909185379638, 0.925605406007452; 0.503740694998205, 0.9258207090107349; 0.508572276305145, 0.926090567056155; 0.513404144365578, 0.9265786452701265; 0.518235295542277, 0.9265211730627181; 0.52306651840735, 0.9265182558974497; 0.527897812960796, 0.9265698937743213; 0.532728964137495, 0.9265124215669158; 0.537560187002568, 0.9265095044016446; 0.54239140986764, 0.9265065872363761; 0.547222561044339, 0.9264491150289706; 0.552053855597785, 0.9265007529058394; 0.556885150151231, 0.926552390782711; 0.561716229639557, 0.9264403635331655; 0.566547595881376, 0.9265465564521742; 0.571378818746449, 0.9265436392869059; 0.576210041611521, 0.9265407221216374; 0.581041264476594, 0.926537804956369; 0.585872630718413, 0.9266439978753749; 0.59070414033698, 0.9268593008786579; 0.595535363202052, 0.9268563837133894; 0.600366586067125, 0.9268534665481211; 0.605197808932197, 0.9268505493828527; 0.61002903179727, 0.9268476322175843; 0.614860254662343, 0.9268447150523159; 0.619691477527415, 0.9268417978870476; 0.624522915457608, 0.9270025458481905; 0.629354568452922, 0.9273269589357506; 0.634186436513355, 0.9278150371497192; 0.639018376262163, 0.9283576704058277; 0.643850172634223, 0.9287911935776622; 0.648681969006283, 0.9292247167494936; 0.653513765378344, 0.9296582399213279; 0.658345991880645, 0.9304190933459878; 0.663177644875958, 0.9307435064335451; 0.668009154494525, 0.930958809436828; 0.672841165931705, 0.9315559977350737; 0.677672890615392, 0.9319349658647681; 0.682504973740946, 0.9325867092051539; 0.68733662673626, 0.9329111222927109; 0.692168853238561, 0.9336719757173708; 0.697000434545501, 0.933941833762791; 0.70183180078732, 0.9340480266817969; 0.706663525471007, 0.934426994811494; 0.711495393531441, 0.9349150730254627; 0.716326688084887, 0.9349667109023342; 0.721157910949959, 0.9349637937370658; 0.725989133815032, 0.9349608765717974; 0.730821001875466, 0.9354489547857661; 0.735652439805659, 0.9356097027469119; 0.740483949424225, 0.9358250057501949; 0.745315243977671, 0.9358766436270637; 0.750146538531117, 0.9359282815039324; 0.754978263214804, 0.9363072496336267; 0.759809844521744, 0.9365771076790469; 0.764641282451937, 0.9367378556401926; 0.76947272038213, 0.9368986036013385; 0.774303943247202, 0.9368956864360701; 0.779135166112275, 0.9368927692708017; 0.783966388977348, 0.9368898521055333; 0.788797683530794, 0.936941489982402; 0.793629694967974, 0.9375386782806477; 0.798461204586541, 0.9377539812839307; 0.80329257082836, 0.9378601742029367; 0.808123793693433, 0.9378572570376683; 0.812955016558505, 0.9378543398723999; 0.817786239423578, 0.9378514227071314; 0.82261746228865, 0.9378485055418629; 0.827448685153723, 0.9378455883765946; 0.832279908018795, 0.9378426712113263; 0.837111130883868, 0.9378397540460578; 0.84194235374894, 0.9378368368807894; 0.846773576614013, 0.9378339197155211; 0.851604799479086, 0.9378310025502526; 0.856436022344158, 0.9378280853849843; 0.861267245209231, 0.937825168219716; 0.866098468074303, 0.9378222510544475; 0.870929690939376, 0.9378193338891792; 0.875760913804448, 0.9378164167239108; 0.880592136669521, 0.9378134995586423; 0.885423359534593, 0.937810582393374; 0.890254582399666, 0.9378076652281057; 0.895085805264739, 0.9378047480628372; 0.899917028129811, 0.9378018308975689; 0.904748322683257, 0.9378534687744375; 0.909580047366944, 0.9382324369041347; 0.914412488934366, 0.939156955455206; 0.919245432320401, 0.9404633593012429; 0.924079307655292, 0.9424789786950682; 0.928913254678557, 0.9445491531310334; 0.933747631832062, 0.9469466578198242; 0.938582367427435, 0.9496169377193007; 0.943417318087928, 0.9524508827451943; 0.948252985632156, 0.955830378192462; 0.95308858148801, 0.9591553185975925; 0.957924750850852, 0.9629166993398257; 0.962760991902068, 0.9667326351241962; 0.967194215255295, 0.9702323947612731; 0.971224707664027, 0.9736341984196076; 0.975255716229047, 0.9774287983813349; 0.979286724794068, 0.9812233983430619; 0.98331816348933, 0.9853453285576147; 0.987349344106447, 0.9892708606204726; 0.991380524723564, 0.9931963926833277; 0.995411447262537, 0.9969255265944909; 0.999441509541028, 1.0])  annotation(
    Placement(transformation(origin = {-196, -34}, extent = {{-10, -10}, {10, 10}})));
equation
// Piecewise definition of i_FC
  if time == 0 then
    fc.i_FC = fc.epsilon;
  else
    fc.i_FC = fcMeter.i;
  end if;
  voltage1.vDC_in = fc.v_FC;
//switch1.control = if pSBatteryStack.cellCalculator.SOC < 0 then false else true;
  connect(ground.term, voltage1.neutral) annotation(
    Line(points = {{-218, 14}, {-206, 14}}, color = {0, 0, 255}));
  connect(voltage1.term, fcMeter.term_p) annotation(
    Line(points = {{-186, 14}, {-178, 14}}, color = {0, 0, 255}));
  connect(bdCond.heat, inverter.heat) annotation(
    Line(points = {{0, 10}, {0, 10}}, color = {176, 0, 0}));
  connect(select.theta_out, inverter.theta) annotation(
    Line(points = {{-6, 22}, {-6, 10}}, color = {0, 0, 127}));
  connect(select.vPhasor_out, inverter.vPhasor) annotation(
    Line(points = {{6, 22}, {6, 10}}, color = {0, 0, 127}, thickness = 0.5));
  connect(phasor.y, select.vPhasor_in) annotation(
    Line(points = {{-12, 60}, {6, 60}, {6, 42}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ACMeter.term_p, inverter.AC) annotation(
    Line(points = {{18, 0}, {10, 0}}, color = {0, 120, 120}));
  connect(pQsource1.term, ACMeter.term_n) annotation(
    Line(points = {{50, 0}, {38, 0}}, color = {0, 120, 120}));
  pQsource1.pq_in[2] = 0;
  connect(pQsource1.pq_in[1], add.y) annotation(
    Line(points = {{54, 10}, {54, 16}}, color = {0, 0, 127}));
  connect(ramp_down.y, add.u1) annotation(
    Line(points = {{70, 62}, {70, 50}, {62, 50}, {62, 38}}, color = {0, 0, 127}));
  connect(step.y, add.u2) annotation(
    Line(points = {{54, 74}, {54, 38}}, color = {0, 0, 127}));
  connect(ramp_up.y, add.u3) annotation(
    Line(points = {{38, 60}, {38, 52}, {46, 52}, {46, 38}}, color = {0, 0, 127}));
  connect(busMeter.term_n, inverter.DC) annotation(
    Line(points = {{-18, 0}, {-10, 0}}, color = {0, 0, 255}));
  connect(busMeter.term_p, bus.term) annotation(
    Line(points = {{-38, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(fcBooster.DCout, boostedFCMeter.term_p) annotation(
    Line(points = {{-128, 14}, {-120, 14}}, color = {0, 0, 255}));
  connect(fcBooster.DCin, fcMeter.term_n) annotation(
    Line(points = {{-148, 14}, {-158, 14}}, color = {0, 0, 255}));
  connect(bdCond1.heat, fcBooster.heat) annotation(
    Line(points = {{-138, 26}, {-138, 24}}, color = {176, 0, 0}));
  connect(transSig1.y, fcBooster.uDC) annotation(
    Line(points = {{-132, 54}, {-132, 24}}, color = {0, 0, 127}));
  connect(batbooster.DCout, boostedBatMeter.term_p) annotation(
    Line(points = {{-128, -18}, {-120, -18}}));
  connect(bdCond2.heat, batbooster.heat) annotation(
    Line(points = {{-138, -30}, {-138, -28}}, color = {176, 0, 0}));
  connect(transSig2.y, batbooster.uDC) annotation(
    Line(points = {{-132, -50}, {-132, -28}}, color = {0, 0, 127}));
  connect(batteryMeter.term_n, batbooster.DCin) annotation(
    Line(points = {{-158, -18}, {-148, -18}}, color = {0, 0, 255}));
  connect(boostedFCMeter.term_n, bus.term) annotation(
    Line(points = {{-100, 14}, {-60, 14}, {-60, 0}}, color = {0, 0, 255}));
  connect(boostedBatMeter.term_n, bus.term) annotation(
    Line(points = {{-100, -18}, {-60, -18}, {-60, 0}}));
  connect(pSBatteryStack.term_p, ground2.term) annotation(
    Line(points = {{-206, -18}, {-218, -18}}, color = {0, 0, 255}));
  connect(pSBatteryStack.term_n, batteryMeter.term_p);
  annotation(
    uses(PowerSystems(version = "2.0.0"), Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
    version = "",
    Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})));
end hybridFC_v004;
