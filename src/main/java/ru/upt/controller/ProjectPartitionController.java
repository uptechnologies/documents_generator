package ru.upt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ru.upt.converter.ProjectPartitionConverter;
import ru.upt.dto.ProjectPartitionDto;
import ru.upt.service.ProjectPartitionService;

@RestController
@RequestMapping(path = "/rest")
public class ProjectPartitionController {
    private final ProjectPartitionService projectPartitionService;

    @Autowired
    public ProjectPartitionController(ProjectPartitionService projectPartitionService) {
        this.projectPartitionService = projectPartitionService;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/projectPartition/{projectPartitionId}")
    public ProjectPartitionDto getProjectPartition(@PathVariable Long projectPartitionId) {
        return ProjectPartitionConverter.convertToDto(projectPartitionService.getById(projectPartitionId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/projectPartition")
    public ProjectPartitionDto postProjectPartition(@RequestBody ProjectPartitionDto projectPartitionDto) {
        return ProjectPartitionConverter.convertToDto(projectPartitionService.save(ProjectPartitionConverter.convertFromDto(projectPartitionDto)));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/projectPartition")
    public ProjectPartitionDto putProjectPartition(@RequestBody ProjectPartitionDto projectPartitionDto) {
        return ProjectPartitionConverter.convertToDto(projectPartitionService.save(ProjectPartitionConverter.convertFromDto(projectPartitionDto)));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/projectPartition")
    public Boolean deleteProjectPartition(@RequestBody ProjectPartitionDto projectPartitionDto) {
        projectPartitionService.delete(ProjectPartitionConverter.convertFromDto(projectPartitionDto));
        return Boolean.TRUE;
    }
}
