import 'package:flutter/widgets.dart';

import '../../../global/models/pdf_model.dart';

class PdfNotifier extends ChangeNotifier {
  PdfModel model = PdfModel.createEmpty();

  void editPdf(PdfModel pdfModel) {
    this.model = pdfModel;
    notifyListeners();
  }

  void editPersonal(Personal personal) {
    model.resumePersonal = personal;
    notifyListeners();
  }

  void editSummary(Summary summary) {
    model.resumeSummary = summary;
    notifyListeners();
  }

  void addEmploymentSection(Section section) {
    List<Section> sections = model.employment!;
    sections.add(section);
    model.employment = sections;
    notifyListeners();
  }

  void removeEmploymentSection(Section section) {
    List<Section> sections = model.employment!;
    sections.remove(section);
    model.employment = sections;
    notifyListeners();
  }

  void editEmploymentSection(Section section) {
    List<Section> sections = model.employment!;

    for (int i = 0; i < sections.length; i++) {
      if (sections[i].sectionId == section.sectionId) {
        sections[i] = section;
        break;
      }
    }
    model.employment = sections;
    notifyListeners();
  }

  void addEducationSection(Section section) {
    List<Section> sections = model.education!;
    sections.add(section);
    model.education = sections;
    notifyListeners();

  }

  void removeEducationSection(Section section) {
    List<Section> sections = model.education!;
    sections.remove(section);
    model.education = sections;
    notifyListeners();
  }

  void editEducationSection(Section section) {
    List<Section> sections = model.education!;

    for (int i = 0; i < sections.length; i++) {
      if (sections[i].sectionId == section.sectionId) {
        sections[i] = section;
        break;
      }
    }
    model.education = sections;
    notifyListeners();
  }

  void addActivitySection(Section section) {
    List<Section> sections = model.activities!;

    sections.add(section);
    model.activities = sections;
    notifyListeners();
  }

  void removeActivitySection(Section section) {
    List<Section> sections = model.activities!;

    sections.remove(section);
    model.activities = sections;
    notifyListeners();
  }

  void editActivitySection(Section section) {
    List<Section> sections = model.activities!;

    for (int i = 0; i < sections.length; i++) {
      if (sections[i].sectionId == section.sectionId) {
        sections[i] = section;
        break;
      }
    }
    model.activities = sections;
    notifyListeners();
  }

  void addSkill(Skill skill) {
    List<Skill> skills = model.skills!;
    skills.add(skill);
    model.skills = skills;
    notifyListeners();
  }

  void removeSkill(Skill skill) {
    List<Skill> skills = model.skills!;

    skills.remove(skill);
    model.skills = skills;
    notifyListeners();
  }

  void editSkill(Skill skill) {
    List<Skill> skills = model.skills!;

    for (int i = 0; i < skills.length; i++) {
      if (skills[i].skillId == skill.skillId) {
        skills[i] = skill;
        break;
      }
    }
    model.skills = skills;
    notifyListeners();
  }

  void addLanguage(Skill skill) {
    List<Skill> languages = model.languages!;
    languages.add(skill);
    notifyListeners();
  }

  void removeLanguage(Skill skill) {
    List<Skill> languages = model.languages!;

    languages.remove(skill);

    model.languages = languages;
    notifyListeners();
  }

  void editLanguage(Skill skill) {
    List<Skill> languages = model.languages!;

    for (int i = 0; i < languages.length; i++) {
      if (languages[i].skillId == skill.skillId) {
        languages[i] = skill;
        break;
      }
    }

    model.languages = languages;
    notifyListeners();
  }

  void addLink(Links link) {
    List<Links> links = model.links!;
    links.add(link);
    model.links = links;
    notifyListeners();
  }

  void removeLink(Links link) {
    List<Links> links = model.links!;
    links.remove(link);
    model.links = links;
    notifyListeners();
  }

  void editLink(Links link) {
    List<Links> links = model.links!;

    for (int i = 0; i < links.length; i++) {
      if (links[i].linksId == link.linksId) {
        links[i] = link;
        break;
      }
    }
    model.links = links;
    notifyListeners();
  }

  void setModal(PdfModel model) {
    this.model = model;
  }
}
