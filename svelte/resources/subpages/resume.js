export default {
  name: 'resume', // do not change
  pageTitle: 'Resume',
  icon: 'mdi-card-account-details',

  experience: {
    title: 'Experience',
    icon: 'mdi-tie',
    data: [
      {
        title: 'Owner',
        start: '10/2018',
        end: 'present',
        company: 'North of 66',
        description: 'Offering technical leadership and site services for small businesses.'
      },
      {
        title: 'Cloud Engineer',
        start: '08/2018',
        end: 'present',
        company: 'Chugach Government Solutions, LLC',
        description: 'Managed Azure and enterprise network services. Acted as senior escalation point when issues arose.'
      },
      {
        title: 'Network Admininistrator III',
        start: '09/2011',
        end: '08/2018',
        company: 'Ukpeagvik Inupiat Corporation',
        description: 'Migrated from Cisco to Juniper network devices. Migrated MPLS network services from one provider to another across 20+ sites and two datacenters.'
      },
    ]
  },
  education: {
    title: 'Education',
    icon: 'mdi-school',
    data: [
      {
        major: 'BBA, Management Information Systems',
        // start: '09/2014',
        end: '05/2015',
        institute: 'University of Alaska, Anchorage',
        description: 'Heavily focused on project management. Spent three semesters taking a project from design to implementation.'
      },
    ]
  },
  certificatesAndAwards: {
    title: 'Certificates/Awards',
    icon: 'mdi-medal',
    data: [
      {
        title: 'Azure Administrator Associate',
        date: '09/2022',
        issuedBy: 'Microsoft',
        uri: 'https://www.credly.com/badges/92269ed6-e524-4b9a-8cf3-463f616a0620'
      },
      {
        title: 'CCNP: Security',
        date: '02/2021',
        issuedBy: 'Cisco',
        uri: 'https://www.credly.com/badges/f526cfc9-78da-4d80-8e5c-7c1a725c742d'
      },
      {
        title: 'CCNA: Route & Switch',
        date: '02/2020',
        issuedBy: 'Cisco',
        uri: 'https://www.credly.com/badges/83cd46c1-23f7-4374-b492-9ba82e0f6410'
      },
      {
        title: 'Security+',
        date: '10/2018',
        issuedBy: 'CompTIA',
        uri: 'https://www.credly.com/badges/b6c63bba-4b21-4508-8494-759dd2c42d30'
      },
    ]
  },
  academic: {
    title: 'Academic',
    icon: 'mdi-library-shelves',
    data: [
      {
        title: 'Research paper on criminals.',
        date: '10/07/2019',
        issuedBy: 'MIT',
        description: 'Published a research paper at MIT about criminal behaviours and predictions.'
      },
    ]
  },
  skills: [
    {
      title: 'Swinging',
      barType: 'line',
      icon: 'mdi-web',
      items: [
        {
          title: 'Horizontally',
          level: 80
        },
        {
          title: 'Vertically',
          level: 90
        },
      ]
    },
    {
      title: 'Design',
      barType: 'line',
      icon: 'mdi-brush-variant',
      items: [
        {
          title: 'Web Design',
          level: 85
        },
        {
          title: 'Photoshop',
          level: 90
        },
        {
          title: 'After Effects',
          level: 80
        },
      ]
    },
    {
      title: 'Languages',
      barType: 'dots',
      icon: 'mdi-earth',
      items: [
        {
          title: 'Albanian',
          level: 100
        },
        {
          title: 'English',
          level: 94
        },
      ]
    },
    {
      title: 'Knowledge',
      barType: 'dots',
      icon: 'mdi-book-open-page-variant',
      items: [
        {
          title: 'Web shoot',
          level: 94
        },
        {
          title: 'Taking pictures',
          level: 91
        },
      ]
    }
  ],
};
