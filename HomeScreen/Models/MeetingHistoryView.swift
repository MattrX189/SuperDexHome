//
//  MeetingHistoryView.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 17/04/26.
//

import SwiftUI

struct MeetingHistoryView: View {
    let meetings: [EventMeeting]
    @State private var showingAddMeeting = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    if meetings.isEmpty {
                        emptyStateView
                    } else {
                        ForEach(meetings.sorted(by: { $0.date > $1.date })) { meeting in
                            MeetingCard(meeting: meeting)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(.bottom, 80) // Space for floating action button
            }
            
            // Floating Action Button
            Button {
                showingAddMeeting = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Add Meeting")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(Color.accentColor)
                .clipShape(Capsule())
                .shadow(color: .accentColor.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showingAddMeeting) {
            AddMeetingView { newMeeting in
                // In a real app, you'd save this to your data model
                print("New meeting added: \(newMeeting.eventName)")
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
                .padding(.bottom, 8)
            
            Text("No Past Meetings")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Your meeting history with this person will appear here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

struct MeetingCard: View {
    let meeting: EventMeeting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with event name and date
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(meeting.eventName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                        Text(meeting.location)
                            .font(.subheadline)
                    }
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text(meeting.formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(Capsule())
            }
            
            Divider()
            
            // Notes section
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "note.text")
                        .font(.caption)
                    Text("Notes")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.secondary)
                
                Text(meeting.notes)
                    .font(.callout)
                    .lineSpacing(4)
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    MeetingHistoryView(meetings: EventMeeting.sampleMeetings)
}

#Preview("Empty State") {
    MeetingHistoryView(meetings: [])
}
