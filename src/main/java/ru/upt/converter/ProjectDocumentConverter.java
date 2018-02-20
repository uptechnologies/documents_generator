package ru.upt.converter;

import ru.upt.dto.BasicProjectDocumentDto;
import ru.upt.dto.ProjectDocumentDto;
import ru.upt.model.ProjectDocument;

import java.util.stream.Collectors;

public class ProjectDocumentConverter {
    public static BasicProjectDocumentDto convertToBasicDto(ProjectDocument projectDocument){
        return new BasicProjectDocumentDto(
                projectDocument.getId(),
                projectDocument.getName(),
                projectDocument.getDocumentationSheets().stream().map(DocumentationSheetConverter::convertToBasicDto).collect(Collectors.toList())
        );
    }

    public static ProjectDocumentDto convertToDto(ProjectDocument projectDocument){
        return new ProjectDocumentDto(
                projectDocument.getId(),
                projectDocument.getName(),
                projectDocument.getDocumentationSheets().stream().map(DocumentationSheetConverter::convertToBasicDto).collect(Collectors.toList())
        );
    }
}
