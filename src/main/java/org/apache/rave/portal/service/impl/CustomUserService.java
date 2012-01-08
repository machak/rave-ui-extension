/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.apache.rave.portal.service.impl;

import org.apache.rave.portal.model.User;
import org.apache.rave.portal.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * Custom User service is to demonstrate how you can extend user service in RAVE and add additional information
 */

@Service(value = "customUserService")
public class CustomUserService extends DefaultUserService {
    private static final Logger logger = LoggerFactory.getLogger(CustomUserService.class);
    private UserRepository userRepository;

    @Autowired
    public CustomUserService(UserRepository userRepository) {
        super(userRepository);
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        logger.info("Custom User Service called to get user information");
        final User user = userRepository.getByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User with username '" + username + "' was not found!");
        }
        fetchCustomCredential(user);
        return user;
    }

    /**
     * This method attempts to load the custom credential and decorates it with
     * additional attributes.
     *
     * @param user for whom the custom credentials are fetched
     */
    private void fetchCustomCredential(User user) {
        try {
            logger.info("Decorating the credential for user" + user.getUsername());
        } catch (Exception e) {
            logger.warn("Unexpected  error:" + e.getMessage());
        }
    }

    @Override
    public User getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof User) {
            return (User) authentication.getPrincipal();
        } else {
            throw new SecurityException("Could not get the authenticated user!");
        }
    }

}