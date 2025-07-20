class StudentModel {
  final String? time;
  final bool? success;
  final String? token;
  final User? user;

  StudentModel({
    this.time,
    this.success,
    this.token,
    this.user,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      time: json['time'],
      success: json['success'],
      token: json['Token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'success': success,
        'Token': token,
        'user': user?.toJson(),
      };
}

class User {
  final ProfileInfo? profileInfo;

  User({this.profileInfo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileInfo: json['profile_info'] != null
          ? ProfileInfo.fromJson(json['profile_info'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'profile_info': profileInfo?.toJson(),
      };
}

class ProfileInfo {
  final String? stdRegId;
  final String? stdId;
  final String? stdNm;
  final String? stdEml;
  final String? stdMble;
  final String? stdDob;
  final String? stdAltEml;
  final String? stdAltMble;
  final String? stdCreatedAt;
  final String? stsSts;
  final String? stdGndr;
  final String? stdWhatsaap;
  final String? stdNm1;
  final String? enrlYrId;
  final String? hrmsSchId;
  final String? stdType;
  final String? rollNo;
  final String? applicationNo;
  final String? referenceNo;
  final String? aoapPgmId;
  final String? aoapSplznId;
  final String? bchId;
  final String? otherAppNo;
  final String? otherDesc;
  final String? studentRegDate;
  final String? stdDocVerFinalStatus;
  final String? stdProfVerFinalStatus;
  final String? stdEligibilityStat;
  final String? appRegId;
  final String? stdNameVerifyStatus;
  final String? stdDobVerifyStatus;
  final String? pgmIdAdmn;
  final String? splznIdAdmn;
  final String? stdProfImportStatus;
  final String? stdEligibilityStatUpdatedBy;
  final String? stdEligibilityStatUpdatedAt;
  final String? stdRegCreatedAt;
  final String? stdAdmType;
  final String? slab;
  final String? whatsappNo;
  final String? contactEmail;
  final String? stdRegUpdtdAt;
  final String? stdRollNoCrtdAt;
  final String? stdidtest;
  final String? remSts;
  final String? stdDocPhyFinalVerStatus;
  final String? stdEnrlSts;
  final String? stdEnrlStsReason;
  final String? remStsBtech;
  final String? stdRegHstlUpdtdAt;
  final String? stdLoginStatus;
  final String? apiData;
  final String? medicalFormSub;
  final String? stdRegGenId;
  final String? genStdNm;
  final String? genStdEml;
  final String? genStdMble;
  final String? genStdDob;
  final String? genStdAltEml;
  final String? genStdAltMble;
  final String? genStdGndr;
  final String? genStdWhatsaap;
  final String? genCreatedAt;
  final String? genUpdatedAt;
  final String? genUpdtdBy;

  ProfileInfo({
    this.stdRegId,
    this.stdId,
    this.stdNm,
    this.stdEml,
    this.stdMble,
    this.stdDob,
    this.stdAltEml,
    this.stdAltMble,
    this.stdCreatedAt,
    this.stsSts,
    this.stdGndr,
    this.stdWhatsaap,
    this.stdNm1,
    this.enrlYrId,
    this.hrmsSchId,
    this.stdType,
    this.rollNo,
    this.applicationNo,
    this.referenceNo,
    this.aoapPgmId,
    this.aoapSplznId,
    this.bchId,
    this.otherAppNo,
    this.otherDesc,
    this.studentRegDate,
    this.stdDocVerFinalStatus,
    this.stdProfVerFinalStatus,
    this.stdEligibilityStat,
    this.appRegId,
    this.stdNameVerifyStatus,
    this.stdDobVerifyStatus,
    this.pgmIdAdmn,
    this.splznIdAdmn,
    this.stdProfImportStatus,
    this.stdEligibilityStatUpdatedBy,
    this.stdEligibilityStatUpdatedAt,
    this.stdRegCreatedAt,
    this.stdAdmType,
    this.slab,
    this.whatsappNo,
    this.contactEmail,
    this.stdRegUpdtdAt,
    this.stdRollNoCrtdAt,
    this.stdidtest,
    this.remSts,
    this.stdDocPhyFinalVerStatus,
    this.stdEnrlSts,
    this.stdEnrlStsReason,
    this.remStsBtech,
    this.stdRegHstlUpdtdAt,
    this.stdLoginStatus,
    this.apiData,
    this.medicalFormSub,
    this.stdRegGenId,
    this.genStdNm,
    this.genStdEml,
    this.genStdMble,
    this.genStdDob,
    this.genStdAltEml,
    this.genStdAltMble,
    this.genStdGndr,
    this.genStdWhatsaap,
    this.genCreatedAt,
    this.genUpdatedAt,
    this.genUpdtdBy,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      stdRegId: json['std_reg_id'],
      stdId: json['std_id'],
      stdNm: json['std_nm'],
      stdEml: json['std_eml'],
      stdMble: json['std_mble'],
      stdDob: json['std_dob'],
      stdAltEml: json['std_alt_eml'],
      stdAltMble: json['std_alt_mble'],
      stdCreatedAt: json['std_created_at'],
      stsSts: json['sts_sts'],
      stdGndr: json['std_gndr'],
      stdWhatsaap: json['std_whatsaap'],
      stdNm1: json['std_nm1'],
      enrlYrId: json['enrl_yr_id'],
      hrmsSchId: json['hrms_sch_id'],
      stdType: json['std_type'],
      rollNo: json['roll_no'],
      applicationNo: json['application_no'],
      referenceNo: json['reference_no'],
      aoapPgmId: json['aoap_pgm_id'],
      aoapSplznId: json['aoap_splzn_id'],
      bchId: json['bch_id'],
      otherAppNo: json['other_app_no'],
      otherDesc: json['other_desc'],
      studentRegDate: json['student_reg_date'],
      stdDocVerFinalStatus: json['std_doc_ver_final_status'],
      stdProfVerFinalStatus: json['std_prof_ver_final_status'],
      stdEligibilityStat: json['std_eligibility_stat'],
      appRegId: json['app_reg_id'],
      stdNameVerifyStatus: json['std_name_verify_status'],
      stdDobVerifyStatus: json['std_dob_verify_status'],
      pgmIdAdmn: json['pgm_id_admn'],
      splznIdAdmn: json['splzn_id_admn'],
      stdProfImportStatus: json['std_prof_import_status'],
      stdEligibilityStatUpdatedBy: json['std_eligibility_stat_updated_by'],
      stdEligibilityStatUpdatedAt: json['std_eligibility_stat_updated_at'],
      stdRegCreatedAt: json['std_reg_created_at'],
      stdAdmType: json['std_adm_type'],
      slab: json['slab'],
      whatsappNo: json['whatsapp_no'],
      contactEmail: json['contact_email'],
      stdRegUpdtdAt: json['std_reg_updtd_at'],
      stdRollNoCrtdAt: json['std_roll_no_crtd_at'],
      stdidtest: json['stdidtest'],
      remSts: json['rem_sts'],
      stdDocPhyFinalVerStatus: json['std_doc_phy_final_ver_status'],
      stdEnrlSts: json['std_enrl_sts'],
      stdEnrlStsReason: json['std_enrl_sts_reason'],
      remStsBtech: json['rem_sts_btech'],
      stdRegHstlUpdtdAt: json['std_reg_hstl_updtd_at'],
      stdLoginStatus: json['std_login_status'],
      apiData: json['api_data'],
      medicalFormSub: json['medical_form_sub'],
      stdRegGenId: json['std_reg_gen_id'],
      genStdNm: json['gen_std_nm'],
      genStdEml: json['gen_std_eml'],
      genStdMble: json['gen_std_mble'],
      genStdDob: json['gen_std_dob'],
      genStdAltEml: json['gen_std_alt_eml'],
      genStdAltMble: json['gen_std_alt_mble'],
      genStdGndr: json['gen_std_gndr'],
      genStdWhatsaap: json['gen_std_whatsaap'],
      genCreatedAt: json['gen_created_at'],
      genUpdatedAt: json['gen_updated_at'],
      genUpdtdBy: json['gen_updtd_by'],
    );
  }

  Map<String, dynamic> toJson() => {
        'std_reg_id': stdRegId,
        'std_id': stdId,
        'std_nm': stdNm,
        'std_eml': stdEml,
        'std_mble': stdMble,
        'std_dob': stdDob,
        'std_alt_eml': stdAltEml,
        'std_alt_mble': stdAltMble,
        'std_created_at': stdCreatedAt,
        'sts_sts': stsSts,
        'std_gndr': stdGndr,
        'std_whatsaap': stdWhatsaap,
        'std_nm1': stdNm1,
        'enrl_yr_id': enrlYrId,
        'hrms_sch_id': hrmsSchId,
        'std_type': stdType,
        'roll_no': rollNo,
        'application_no': applicationNo,
        'reference_no': referenceNo,
        'aoap_pgm_id': aoapPgmId,
        'aoap_splzn_id': aoapSplznId,
        'bch_id': bchId,
        'other_app_no': otherAppNo,
        'other_desc': otherDesc,
        'student_reg_date': studentRegDate,
        'std_doc_ver_final_status': stdDocVerFinalStatus,
        'std_prof_ver_final_status': stdProfVerFinalStatus,
        'std_eligibility_stat': stdEligibilityStat,
        'app_reg_id': appRegId,
        'std_name_verify_status': stdNameVerifyStatus,
        'std_dob_verify_status': stdDobVerifyStatus,
        'pgm_id_admn': pgmIdAdmn,
        'splzn_id_admn': splznIdAdmn,
        'std_prof_import_status': stdProfImportStatus,
        'std_eligibility_stat_updated_by': stdEligibilityStatUpdatedBy,
        'std_eligibility_stat_updated_at': stdEligibilityStatUpdatedAt,
        'std_reg_created_at': stdRegCreatedAt,
        'std_adm_type': stdAdmType,
        'slab': slab,
        'whatsapp_no': whatsappNo,
        'contact_email': contactEmail,
        'std_reg_updtd_at': stdRegUpdtdAt,
        'std_roll_no_crtd_at': stdRollNoCrtdAt,
        'stdidtest': stdidtest,
        'rem_sts': remSts,
        'std_doc_phy_final_ver_status': stdDocPhyFinalVerStatus,
        'std_enrl_sts': stdEnrlSts,
        'std_enrl_sts_reason': stdEnrlStsReason,
        'rem_sts_btech': remStsBtech,
        'std_reg_hstl_updtd_at': stdRegHstlUpdtdAt,
        'std_login_status': stdLoginStatus,
        'api_data': apiData,
        'medical_form_sub': medicalFormSub,
        'std_reg_gen_id': stdRegGenId,
        'gen_std_nm': genStdNm,
        'gen_std_eml': genStdEml,
        'gen_std_mble': genStdMble,
        'gen_std_dob': genStdDob,
        'gen_std_alt_eml': genStdAltEml,
        'gen_std_alt_mble': genStdAltMble,
        'gen_std_gndr': genStdGndr,
        'gen_std_whatsaap': genStdWhatsaap,
        'gen_created_at': genCreatedAt,
        'gen_updated_at': genUpdatedAt,
        'gen_updtd_by': genUpdtdBy,
      };
}
