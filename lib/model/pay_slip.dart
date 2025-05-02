class PaySlip {
  PaySlip({
     this.status,
     this.result,
     this.error,
     this.version,
  });
  late final bool? status;
  late final Result? result;
  late final String? error;
  late final String? version;

  PaySlip.fromJson(Map<String, dynamic> json){
    status = json['status'];
    result = Result.fromJson(json['result']);
    error = json['error'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result!.toJson();
    _data['error'] = error;
    _data['version'] = version;
    return _data;
  }
}

class Result {
  Result({
    required this.empcode,
    required this.name,
    required this.doj,
    required this.actualPresentDays,
    required this.locName,
    required this.department,
    required this.designation,
    required this.bank,
    required this.bankAcc,
    required this.uanNo,
    required this.pfNo,
    required this.pan,
    required this.el,
    required this.cl,
    required this.sl,
    required this.basic,
    required this.hra,
    required this.specialAllowance,
    required this.bonus,
    required this.otherAllowance,
    required this.grossSalary,
    required this.employeePf,
    required this.employeeEsic,
    required this.employeeWelfare,
    required this.salaryAdvance,
    required this.incomeTax,
    required this.pta,
    required this.totalDeduction,
    required this.salaryCredit,
    required this.amountInWords,
    required this.offeredBasic,
    required this.offeredHra,
    required this.offeredSpAllowance,
    required this.offeredOthersAllowance,
    required this.offeredGrossSalary,
    required this.totalDeductionUnderViA,
    required this.forInvestment,
    required this.pfVpf,
    required this.totalInvestmentUnder_80c,
    required this.forIinvestments,
    required this.rentPaid,
    required this.actualHra,
    required this.basicAnnually,
    required this.tenPer,
    required this.rent_10Basic,
    required this.per_40OfBasic,
    required this.leastOfAbove,
    required this.standardDeduction,
    required this.taxableIncome,
    required this.taxSlabCalculation,
    required this.incomeTaxLiability,
    required this.taxRebate_87a,
    required this.subTotal,
    required this.surchargeCess,
    required this.totalTax,
    required this.previousEmployerTax,
    required this.netTax,
    required this.taxDeductionTillLastMonth,
    required this.taxToBeDeduction,
    required this.taxDeductionForThisMonth,
    required this.revisedTax,
    required this.entity,
    required this.modifiedby,
    required this.modifiedon,
    required this.totalPresentDays,
    required this.month,
    required this.year,
  });
  late final String? empcode;
  late final String? name;
  late final String? doj;
  late final String? actualPresentDays;
  late final String? locName;
  late final String? department;
  late final String? designation;
  late final String? bank;
  late final String? bankAcc;
  late final String? uanNo;
  late final String? pfNo;
  late final String? pan;
  late final String? el;
  late final String? cl;
  late final String? sl;
  late final String? basic;
  late final String? hra;
  late final String? specialAllowance;
  late final String? bonus;
  late final String? otherAllowance;
  late final String? grossSalary;
  late final String? employeePf;
  late final String? employeeEsic;
  late final String? employeeWelfare;
  late final String? salaryAdvance;
  late final String? incomeTax;
  late final String? pta;
  late final String? totalDeduction;
  late final String? salaryCredit;
  late final String? amountInWords;
  late final String? offeredBasic;
  late final String? offeredHra;
  late final String? offeredSpAllowance;
  late final String? offeredOthersAllowance;
  late final String? offeredGrossSalary;
  late final String? totalDeductionUnderViA;
  late final String? forInvestment;
  late final String? pfVpf;
  late final String? totalInvestmentUnder_80c;
  late final String? forIinvestments;
  late final String? rentPaid;
  late final String? actualHra;
  late final String? basicAnnually;
  late final String? tenPer;
  late final String? rent_10Basic;
  late final String? per_40OfBasic;
  late final String? leastOfAbove;
  late final String? standardDeduction;
  late final String? taxableIncome;
  late final String? taxSlabCalculation;
  late final String? incomeTaxLiability;
  late final String? taxRebate_87a;
  late final String? subTotal;
  late final String? surchargeCess;
  late final String? totalTax;
  late final String? previousEmployerTax;
  late final String? netTax;
  late final String? taxDeductionTillLastMonth;
  late final String? taxToBeDeduction;
  late final String? taxDeductionForThisMonth;
  late final String? revisedTax;
  late final String? entity;
  late final String? modifiedby;
  late final String? modifiedon;
  late final String? totalPresentDays;
  late final int? month;
  late final int? year;

  Result.fromJson(Map<String, dynamic> json){
    empcode = json['empcode'];
    name = json['name'];
    doj = json['doj'];
    actualPresentDays = json['actual_present_days'];
    locName = json['loc_name'];
    department = json['department'];
    designation = json['designation'];
    bank = json['bank'];
    bankAcc = json['bank_acc'];
    uanNo = json['uan_no'];
    pfNo = json['pf_no'];
    pan = json['pan'];
    el = json['el'];
    cl = json['cl'];
    sl = json['sl'];
    basic = json['basic'];
    hra = json['hra'];
    specialAllowance = json['special_allowance'];
    bonus = json['bonus'];
    otherAllowance = json['other_allowance'];
    grossSalary = json['gross_salary'];
    employeePf = json['employee_pf'];
    employeeEsic = json['employee_esic'];
    employeeWelfare = json['employee_welfare'];
    salaryAdvance = json['salary_advance'];
    incomeTax = json['income_tax'];
    pta = json['pta'];
    totalDeduction = json['total_deduction'];
    salaryCredit = json['salary_credit'];
    amountInWords = json['amount_in_words'];
    offeredBasic = json['offered_basic'];
    offeredHra = json['offered_hra'];
    offeredSpAllowance = json['offered_sp_allowance'];
    offeredOthersAllowance = json['offered_others_allowance'];
    offeredGrossSalary = json['offered_gross_salary'];
    totalDeductionUnderViA = json['total_deduction_under_vi_a'];
    forInvestment = json['for_investment'];
    pfVpf = json['pf_vpf'];
    totalInvestmentUnder_80c = json['total_investment_under_80c'];
    forIinvestments = json['for_iinvestments'];
    rentPaid = json['rent_paid'];
    actualHra = json['actual_hra'];
    basicAnnually = json['basic_annually'];
    tenPer = json['ten_per'];
    rent_10Basic = json['rent_10_basic'];
    per_40OfBasic = json['per_40_of_basic'];
    leastOfAbove = json['least_of_above'];
    standardDeduction = json['standard_deduction'];
    taxableIncome = json['taxable_income'];
    taxSlabCalculation = json['tax_slab_calculation'];
    incomeTaxLiability = json['income_tax_liability'];
    taxRebate_87a = json['tax_rebate_87a'];
    subTotal = json['sub_total'];
    surchargeCess = json['surcharge_cess'];
    totalTax = json['total_tax'];
    previousEmployerTax = json['previous_employer_tax'];
    netTax = json['net_tax'];
    taxDeductionTillLastMonth = json['tax_deduction_till_last_month'];
    taxToBeDeduction = json['tax_to_be_deduction'];
    taxDeductionForThisMonth = json['tax_deduction_for_this_month'];
    revisedTax = json['revised_tax'];
    entity = json['entity'];
    modifiedby = json['modifiedby'];
    modifiedon = json['modifiedon'];
    totalPresentDays = json['total_present_days'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empcode'] = empcode;
    _data['name'] = name;
    _data['doj'] = doj;
    _data['actual_present_days'] = actualPresentDays;
    _data['loc_name'] = locName;
    _data['department'] = department;
    _data['designation'] = designation;
    _data['bank'] = bank;
    _data['bank_acc'] = bankAcc;
    _data['uan_no'] = uanNo;
    _data['pf_no'] = pfNo;
    _data['pan'] = pan;
    _data['el'] = el;
    _data['cl'] = cl;
    _data['sl'] = sl;
    _data['basic'] = basic;
    _data['hra'] = hra;
    _data['special_allowance'] = specialAllowance;
    _data['bonus'] = bonus;
    _data['other_allowance'] = otherAllowance;
    _data['gross_salary'] = grossSalary;
    _data['employee_pf'] = employeePf;
    _data['employee_esic'] = employeeEsic;
    _data['employee_welfare'] = employeeWelfare;
    _data['salary_advance'] = salaryAdvance;
    _data['income_tax'] = incomeTax;
    _data['pta'] = pta;
    _data['total_deduction'] = totalDeduction;
    _data['salary_credit'] = salaryCredit;
    _data['amount_in_words'] = amountInWords;
    _data['offered_basic'] = offeredBasic;
    _data['offered_hra'] = offeredHra;
    _data['offered_sp_allowance'] = offeredSpAllowance;
    _data['offered_others_allowance'] = offeredOthersAllowance;
    _data['offered_gross_salary'] = offeredGrossSalary;
    _data['total_deduction_under_vi_a'] = totalDeductionUnderViA;
    _data['for_investment'] = forInvestment;
    _data['pf_vpf'] = pfVpf;
    _data['total_investment_under_80c'] = totalInvestmentUnder_80c;
    _data['for_iinvestments'] = forIinvestments;
    _data['rent_paid'] = rentPaid;
    _data['actual_hra'] = actualHra;
    _data['basic_annually'] = basicAnnually;
    _data['ten_per'] = tenPer;
    _data['rent_10_basic'] = rent_10Basic;
    _data['per_40_of_basic'] = per_40OfBasic;
    _data['least_of_above'] = leastOfAbove;
    _data['standard_deduction'] = standardDeduction;
    _data['taxable_income'] = taxableIncome;
    _data['tax_slab_calculation'] = taxSlabCalculation;
    _data['income_tax_liability'] = incomeTaxLiability;
    _data['tax_rebate_87a'] = taxRebate_87a;
    _data['sub_total'] = subTotal;
    _data['surcharge_cess'] = surchargeCess;
    _data['total_tax'] = totalTax;
    _data['previous_employer_tax'] = previousEmployerTax;
    _data['net_tax'] = netTax;
    _data['tax_deduction_till_last_month'] = taxDeductionTillLastMonth;
    _data['tax_to_be_deduction'] = taxToBeDeduction;
    _data['tax_deduction_for_this_month'] = taxDeductionForThisMonth;
    _data['revised_tax'] = revisedTax;
    _data['entity'] = entity;
    _data['modifiedby'] = modifiedby;
    _data['modifiedon'] = modifiedon;
    _data['total_present_days'] = totalPresentDays;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}