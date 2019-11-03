package com.vuchobe.api.json;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.views.Views;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class JsonPage<T> extends PageImpl<T> {

    private JsonSort sort;

    public JsonPage(final List<T> content, final Pageable pageable, final long total) {
        super(content, pageable, total);
    }

    public JsonPage(Page<T> page) {
        super(page.getContent(), page.getPageable(), page.getTotalPages());
        this.sort = new JsonSort(page.getSort().get().collect(Collectors.toList()));
    }

    public JsonPage(final List<T> content) {
        super(content);
    }

    public JsonPage(final Page<T> page, final Pageable pageable) {
        super(page.getContent(), pageable, page.getTotalElements());

        this.sort = new JsonSort(pageable.getSort().get().collect(Collectors.toList()));
    }

    @JsonView(Views.List.class)
    public int getTotalPages() {
        return super.getTotalPages();
    }

    @JsonView(Views.List.class)
    public long getTotalElements() {
        return super.getTotalElements();
    }

    @JsonView(Views.List.class)
    public boolean hasNext() {
        return super.hasNext();
    }

    @JsonView(Views.List.class)
    public boolean isLast() {
        return super.isLast();
    }

    @JsonView(Views.List.class)
    public boolean hasContent() {
        return super.hasContent();
    }

    @JsonView(Views.List.class)
    public List<T> getContent() {
        return super.getContent();
    }

    @Override
    @JsonView(Views.List.class)
    public JsonSort getSort() {
        return sort;
    }

    public void setSort(JsonSort sort) {
        this.sort = sort;
    }

    public class JsonSort extends Sort {
        private List<String> fields = new ArrayList<>();

        public JsonSort(Order... orders) {
            super(orders);
        }

        public JsonSort(List<Order> orders) {
            super(orders);
            orders.forEach(item -> {
                fields.add(item.getProperty());
            });
        }

        public JsonSort(String... properties) {
            super(properties);
        }

        public JsonSort(Direction direction, String... properties) {
            super(direction, properties);
        }

        public JsonSort(Direction direction, List<String> properties) {
            super(direction, properties);
        }

        @Override
        @JsonView(Views.List.class)
        public boolean isSorted() {
            return super.isSorted();
        }

        @Override
        @JsonView(Views.List.class)
        public boolean isUnsorted() {
            return super.isUnsorted();
        }

        @Override
        public Order getOrderFor(String property) {
            return super.getOrderFor(property);
        }

        @JsonView(Views.List.class)
        public List<String> getFields() {
            return fields;
        }

        public void setFields(List<String> fields) {
            this.fields = fields;
        }
    }
}
