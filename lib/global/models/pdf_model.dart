import 'dart:convert';
import 'dart:core';

import '../constants/constants.dart';

class Section {
  Section({
    required this.sectionId,
    this.textOne,
    this.textTwo,
    this.textThree,
    this.description,
    this.startDate,
    this.endDate,
    this.position = 0,
  });

  String sectionId = "";
  String? textOne;
  String? textTwo;
  String? textThree;
  String? description;
  String? startDate;
  String? endDate;
  int? position = 0;

  Section.fromJson(dynamic json) {
    sectionId = json['sectionId'];
    textOne = json['textOne'];
    textTwo = json['textTwo'];
    textThree = json['textThree'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    // _nextPageUrl = json['next_page_url'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sectionId'] = sectionId;
    map['textOne'] = textOne;
    map['textTwo'] = textTwo;
    map['textThree'] = textThree;
    map['description'] = description;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['position'] = position;
    return map;
  }

  Section.createEmpty(String defaultTitle) {
    sectionId = uuid.v4();
    textOne = defaultTitle;
  }
}

class Personal {
  Personal({
    this.sectionTitle,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.image,
    this.nationality,
    this.jobTitle,
    this.city,
    this.dateOfBirth,
  });

  String? sectionTitle;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  String? nationality;
  String? jobTitle;
  String? city;
  String? dateOfBirth;

  Personal.fromJson(dynamic json) {
    sectionTitle = json['sectionTitle'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    nationality = json['nationality'];
    jobTitle = json['jobTitle'];
    city = json['city'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sectionTitle'] = sectionTitle;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['image'] = image;
    map['nationality'] = nationality;
    map['jobTitle'] = jobTitle;
    map['city'] = city;
    map['dateOfBirth'] = dateOfBirth;
    return map;
  }

  Personal.createEmpty() {
    sectionTitle = "";
  }
}

class Summary {
  Summary({
    this.sectionTitle,
    this.professionalSummary,
  });

  String? sectionTitle;
  String? professionalSummary;

  Summary.fromJson(dynamic json) {
    sectionTitle = json['sectionTitle'];
    professionalSummary = json['professionalSummary'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sectionTitle'] = sectionTitle;
    map['professionalSummary'] = professionalSummary;
    return map;
  }

  Summary.createEmpty() {}
}

class Skill {
  Skill({required this.skillId, this.skillName, this.skillProficieny, this.position = 0});

  String skillId = "";
  String? skillName;
  String? skillProficieny;
  int? position;

  Skill.fromJson(dynamic json) {
    skillId = json['skillId'];
    skillName = json['skillName'];
    skillProficieny = json['skillProficieny'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['skillId'] = skillId;
    map['skillName'] = skillName;
    map['skillProficieny'] = skillProficieny;
    map['position'] = position;
    return map;
  }

  Skill.createEmpty(String defaultName) {
    skillId = uuid.v4();
    skillName = defaultName;
  }
}

class Links {
  Links({required this.linksId, this.linkName, this.linkUrl, this.position});

  String linksId = "";
  String? linkName;
  String? linkUrl;
  int? position;

  Links.fromJson(dynamic json) {
    linksId = json['linksId'];
    linkName = json['linkName'];
    linkUrl = json['linkUrl'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['linksId'] = linksId;
    map['linkName'] = linkName;
    map['linkUrl'] = linkUrl;
    map['position'] = position;
    return map;
  }

  Links.createEmpty() {
    linksId = uuid.v4();
    linkName = "Link";
  }
}

class PdfModel {
  PdfModel({
    required this.pdfId,
    this.resumeTitle,
    this.employment,
    this.education,
    this.activities,
    this.languages,
    this.skills,
    this.hobbies,
    this.links,
    this.resumeSummary,
    this.resumePersonal,
  });

  String pdfId = "";
  String? resumeTitle = "";
  List<Section>? employment = [];
  List<Section>? education = [];
  List<Section>? activities = [];
  List<Skill>? languages = [];
  List<Skill>? skills = [];
  List<Skill>? hobbies = [];
  List<Links>? links = [];
  Summary? resumeSummary = Summary();
  Personal? resumePersonal = Personal();

  PdfModel.fromJson(dynamic json) {
    pdfId = json['pdfId'];
    resumeTitle = json['resumeTitle'];
    if (json['employment'] != null) {
      employment = [];
      json['employment'].forEach((v) {
        employment?.add(Section.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = [];
      json['education'].forEach((v) {
        education?.add(Section.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities?.add(Section.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Skill.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = [];
      json['skills'].forEach((v) {
        skills?.add(Skill.fromJson(v));
      });
    }
    if (json['hobbies'] != null) {
      hobbies = [];
      json['hobbies'].forEach((v) {
        hobbies?.add(Skill.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    resumeSummary = json['resumeSummary'] != null ? Summary.fromJson(json['resumeSummary']) : null;
    resumePersonal = json['resumePersonal'] != null ? Personal.fromJson(json['resumePersonal']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pdfId'] = pdfId;
    map['resumeTitle'] = resumeTitle;
    if (employment != null) {
      map['employment'] = employment?.map((v) => v.toJson()).toList();
    }
    if (education != null) {
      map['education'] = education?.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      map['activities'] = activities?.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      map['languages'] = languages?.map((v) => v.toJson()).toList();
    }
    if (skills != null) {
      map['skills'] = skills?.map((v) => v.toJson()).toList();
    }
    if (hobbies != null) {
      map['hobbies'] = hobbies?.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['resumeSummary'] = resumeSummary!.toJson();
    map['resumePersonal'] = resumePersonal!.toJson();
    return map;
  }

  PdfModel.createEmpty() {
    pdfId = uuid.v4();
    resumeTitle = "";
    employment = [];
    education = [];
    activities = [];
    skills = [];
    hobbies = [];
    links = [];
    languages = [];
    resumeSummary = Summary();
    resumePersonal = Personal();
  }

  static String encodeList(List<PdfModel> musics) => json.encode(
        musics.map<Map<String, dynamic>>((music) => music.toJson()).toList(),
      );

  static List<PdfModel> decodeList(String musics) => (json.decode(musics) as List<dynamic>).map<PdfModel>((item) => PdfModel.fromJson(item)).toList();
}
